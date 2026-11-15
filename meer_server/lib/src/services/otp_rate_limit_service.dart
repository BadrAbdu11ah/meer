import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

typedef OtpClientIpResolver = String? Function(Session session);

class OtpRateLimitService {
  OtpRateLimitService({
    this._clientIpResolver,
  });

  final OtpClientIpResolver? _clientIpResolver;

  static const sendPurpose = 'send';
  static const verifyPurpose = 'verify';

  static const _retentionPeriod = Duration(hours: 24);

  static const _sendPhoneLimits = [
    _RateWindow(Duration(seconds: 60), 1),
    _RateWindow(Duration(minutes: 15), 3),
    _RateWindow(Duration(hours: 24), 8),
  ];

  static const _sendIpLimits = [
    _RateWindow(Duration(minutes: 15), 20),
    _RateWindow(Duration(hours: 24), 100),
  ];

  static const _verifyPhoneLimits = [
    _RateWindow(Duration(minutes: 10), 5),
  ];

  static const _verifyIpLimits = [
    _RateWindow(Duration(minutes: 10), 40),
  ];

  Future<bool> allowAttempt(
    Session session, {
    required String phone,
    required String purpose,
  }) async {
    final normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');

    if (normalizedPhone.isEmpty) {
      throw FormatException('رقم الهاتف غير صالح.');
    }

    late final List<_RateWindow> phoneLimits;
    late final List<_RateWindow> ipLimits;

    switch (purpose) {
      case sendPurpose:
        phoneLimits = _sendPhoneLimits;
        ipLimits = _sendIpLimits;
        break;

      case verifyPurpose:
        phoneLimits = _verifyPhoneLimits;
        ipLimits = _verifyIpLimits;
        break;

      default:
        throw ArgumentError.value(purpose, 'purpose');
    }

    final secret = _getSecret(session);

    final phoneHash = _createHash(
      secret,
      'phone:$normalizedPhone',
    );

    final ipAddress = _clientIpResolver == null
        ? _getClientIp(session)
        : _clientIpResolver(session);

    final ipHash = ipAddress == null
        ? null
        : _createHash(secret, 'ip:$ipAddress');

    // ترتيب المفاتيح يمنع اختلاف ترتيب الأقفال بين الطلبات المتزامنة.
    final lockKeys = [
      'otp:$purpose:phone:$phoneHash',
      if (ipHash != null) 'otp:$purpose:ip:$ipHash',
    ]..sort();

    return session.db.transaction(
      (transaction) async {
        // قفل عداد الهاتف وعداد IP حتى تنتهي المعاملة.
        for (final lockKey in lockKeys) {
          await session.db.unsafeQuery(
            'SELECT pg_advisory_xact_lock('
            'hashtextextended(@lockKey, 0))',
            parameters: QueryParameters.named({
              'lockKey': lockKey,
            }),
            transaction: transaction,
          );
        }

        final now = DateTime.now().toUtc();

        // حذف المحاولات المنتهية لهذا الرقم وهذا الغرض.
        await OtpAttempt.db.deleteWhere(
          session,
          where: (t) =>
              t.phoneHash.equals(phoneHash) &
              t.purpose.equals(purpose) &
              (t.createdAt < now.subtract(_retentionPeriod)),
          transaction: transaction,
          noReturn: true,
        );

        // فحص حدود الهاتف.
        for (final rule in phoneLimits) {
          final cutoff = now.subtract(rule.window);

          final count = await OtpAttempt.db.count(
            session,
            where: (t) =>
                t.phoneHash.equals(phoneHash) &
                t.purpose.equals(purpose) &
                (t.createdAt > cutoff),
            transaction: transaction,
          );

          if (count >= rule.maxAttempts) {
            return false;
          }
        }

        // حذف المحاولات المنتهية لعنوان IP الحالي.
        if (ipHash != null) {
          await OtpAttempt.db.deleteWhere(
            session,
            where: (t) =>
                t.ipHash.equals(ipHash) &
                t.purpose.equals(purpose) &
                (t.createdAt < now.subtract(_retentionPeriod)),
            transaction: transaction,
            noReturn: true,
          );

          // فحص حدود IP.
          for (final rule in ipLimits) {
            final cutoff = now.subtract(rule.window);

            final count = await OtpAttempt.db.count(
              session,
              where: (t) =>
                  t.ipHash.equals(ipHash) &
                  t.purpose.equals(purpose) &
                  (t.createdAt > cutoff),
              transaction: transaction,
            );

            if (count >= rule.maxAttempts) {
              return false;
            }
          }
        }

        // تسجيل المحاولة المسموحة قبل استدعاء مزود الرسائل.
        await OtpAttempt.db.insertRow(
          session,
          OtpAttempt(
            phoneHash: phoneHash,
            ipHash: ipHash,
            purpose: purpose,
            createdAt: now,
          ),
          transaction: transaction,
        );

        return true;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.readCommitted,
      ),
    );
  }

  String _getSecret(Session session) {
    final secret =
        session.serverpod.getPassword('otpRateLimitSecret') ??
        session.passwords['otpRateLimitSecret'];

    if (secret == null || secret.trim().isEmpty) {
      throw StateError(
        'otpRateLimitSecret is missing from server configuration.',
      );
    }

    return secret;
  }

  String _createHash(String secret, String value) {
    final hmac = Hmac(
      sha256,
      utf8.encode(secret),
    );

    return hmac.convert(utf8.encode(value)).toString();
  }

  String? _getClientIp(Session session) {
    final request = session.request;

    if (request == null) return null;

    final address = request.remoteInfo.trim();

    return address.isEmpty ? null : address;
  }
}

class _RateWindow {
  final Duration window;
  final int maxAttempts;

  const _RateWindow(this.window, this.maxAttempts);
}
