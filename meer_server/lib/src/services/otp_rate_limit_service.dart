import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

typedef OtpClientIpResolver = String? Function(Session session);

/// كل القيم الرقمية لحدود OTP في مكان واحد.
///
/// الحدود العامة (300/ساعة و1000/يوم) مبدئية لمرحلة MVP وتُراجع مقابل حجم
/// الاستخدام الفعلي وميزانية الرسائل قبل الإنتاج.
class OtpRateLimits {
  const OtpRateLimits({
    this.sendPhone = const [
      OtpRateWindow(Duration(seconds: 60), 1),
      OtpRateWindow(Duration(minutes: 15), 3),
      OtpRateWindow(Duration(hours: 24), 8),
    ],
    this.sendIp = const [
      OtpRateWindow(Duration(minutes: 15), 20),
      OtpRateWindow(Duration(hours: 24), 100),
    ],
    this.sendGlobal = const [
      OtpRateWindow(Duration(hours: 1), 300),
      OtpRateWindow(Duration(hours: 24), 1000),
    ],
    this.verifyPhone = const [
      OtpRateWindow(Duration(minutes: 10), 5),
    ],
    this.verifyIp = const [
      OtpRateWindow(Duration(minutes: 10), 40),
    ],
    this.retentionPeriod = const Duration(hours: 24),
  });

  final List<OtpRateWindow> sendPhone;
  final List<OtpRateWindow> sendIp;

  /// حد عام على كل الإرسالات (لكل الأرقام وكل العناوين) كقاطع طوارئ يحمي
  /// رصيد الرسائل لو تجاوز مهاجم حدود الرقم والعنوان. يطبق على الإرسال فقط.
  final List<OtpRateWindow> sendGlobal;

  final List<OtpRateWindow> verifyPhone;
  final List<OtpRateWindow> verifyIp;

  /// يجب ألا تقل عن أطول نافذة في الحدود أعلاه.
  final Duration retentionPeriod;
}

class OtpRateWindow {
  const OtpRateWindow(this.window, this.maxAttempts);

  final Duration window;
  final int maxAttempts;
}

class OtpRateLimitService {
  OtpRateLimitService({
    this._clientIpResolver,
    this.limits = const OtpRateLimits(),
  });

  final OtpClientIpResolver? _clientIpResolver;
  final OtpRateLimits limits;

  static const sendPurpose = 'send';
  static const verifyPurpose = 'verify';

  /// مفتاح ثابت لقفل العداد العام، حتى تمر كل طلبات الإرسال على نفس القفل.
  static const _globalSendLockKey = 'otp:send:global';

  Future<bool> allowAttempt(
    Session session, {
    required String phone,
    required String purpose,
  }) async {
    final normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');

    if (normalizedPhone.isEmpty) {
      throw FormatException('رقم الهاتف غير صالح.');
    }

    late final List<OtpRateWindow> phoneLimits;
    late final List<OtpRateWindow> ipLimits;
    late final List<OtpRateWindow> globalLimits;

    switch (purpose) {
      case sendPurpose:
        phoneLimits = limits.sendPhone;
        ipLimits = limits.sendIp;
        globalLimits = limits.sendGlobal;
        break;

      case verifyPurpose:
        phoneLimits = limits.verifyPhone;
        ipLimits = limits.verifyIp;
        // التحقق لا يستهلك الحصة العامة للإرسال.
        globalLimits = const [];
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
      if (globalLimits.isNotEmpty) _globalSendLockKey,
    ]..sort();

    return session.db.transaction(
      (transaction) async {
        // قفل عداد الهاتف وعداد IP والعداد العام حتى تنتهي المعاملة.
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

        // حذف كل المحاولات المنتهية (لكل الأرقام والعناوين) حتى لا ينمو الجدول.
        await OtpAttempt.db.deleteWhere(
          session,
          where: (t) => t.createdAt < now.subtract(limits.retentionPeriod),
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

        if (ipHash != null) {
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

        // فحص الحد العام.
        for (final rule in globalLimits) {
          final cutoff = now.subtract(rule.window);

          final count = await OtpAttempt.db.count(
            session,
            where: (t) => t.purpose.equals(purpose) & (t.createdAt > cutoff),
            transaction: transaction,
          );

          if (count >= rule.maxAttempts) {
            return false;
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

    final address = resolveOtpClientIp(
      socketAddress: request.connectionInfo.remote.address.toString(),
      forwardedFor:
          request.headers.xForwardedFor?.addresses.toList() ?? const [],
      trustedProxies: _getTrustedProxies(session),
    ).trim();

    return address.isEmpty ? null : address;
  }

  /// إعداد الوسطاء الموثوقين من passwords.yaml (أو متغيرات البيئة):
  ///
  /// - otpTrustedProxyHops: عدد الوسطاء أمام الخادم (0 = الخادم مكشوف مباشرة).
  /// - otpTrustedProxyCidrs: نطاقات عناوين هؤلاء الوسطاء، مفصولة بفواصل.
  ///
  /// لا تُقرأ X-Forwarded-For إلا إذا ضُبط الاثنان معًا. لا تضع أي قيمة قبل أن
  /// تتأكد من مزود الاستضافة من سلسلة الوسطاء الفعلية ونطاقات عناوينها.
  OtpTrustedProxies _getTrustedProxies(Session session) {
    String? read(String key) =>
        session.serverpod.getPassword(key) ?? session.passwords[key];

    final proxies = OtpTrustedProxies.parse(
      hops: read('otpTrustedProxyHops'),
      cidrs: read('otpTrustedProxyCidrs'),
    );

    if (proxies.configError case final error?) {
      // لا نسجل أي عنوان IP هنا، فقط سبب تعطيل قراءة الترويسة.
      session.log(
        'OTP trusted proxy configuration ignored: $error',
        level: LogLevel.warning,
      );
    }

    return proxies;
  }
}

/// الوسطاء (reverse proxies) الذين يُسمح لهم بتحديد عنوان العميل.
///
/// أي خطأ في الإعداد يعطّل الثقة بالكامل بدل أن يوسّعها.
class OtpTrustedProxies {
  const OtpTrustedProxies._(this.hops, this._networks, this.configError);

  static const none = OtpTrustedProxies._(0, [], null);

  static const maxHops = 5;

  factory OtpTrustedProxies({
    required int hops,
    required List<String> cidrs,
  }) {
    if (hops == 0 && cidrs.isEmpty) return none;

    if (hops < 0 || hops > maxHops) {
      return const OtpTrustedProxies._(
        0,
        [],
        'otpTrustedProxyHops must be between 0 and $maxHops.',
      );
    }

    final networks = <_IpNetwork>[];

    for (final cidr in cidrs) {
      final network = _IpNetwork.tryParse(cidr);

      if (network == null) {
        return const OtpTrustedProxies._(
          0,
          [],
          'otpTrustedProxyCidrs contains an invalid CIDR.',
        );
      }

      networks.add(network);
    }

    if (hops > 0 && networks.isEmpty) {
      return const OtpTrustedProxies._(
        0,
        [],
        'otpTrustedProxyHops is set without otpTrustedProxyCidrs.',
      );
    }

    if (hops == 0) return none;

    return OtpTrustedProxies._(hops, List.unmodifiable(networks), null);
  }

  /// يقرأ القيم النصية كما تأتي من الإعدادات.
  factory OtpTrustedProxies.parse({String? hops, String? cidrs}) {
    final hopsText = hops?.trim() ?? '';
    final parsedHops = hopsText.isEmpty ? 0 : int.tryParse(hopsText);

    if (parsedHops == null) {
      return const OtpTrustedProxies._(
        0,
        [],
        'otpTrustedProxyHops is not a whole number.',
      );
    }

    return OtpTrustedProxies(
      hops: parsedHops,
      cidrs: [
        for (final cidr in (cidrs ?? '').split(','))
          if (cidr.trim().isNotEmpty) cidr.trim(),
      ],
    );
  }

  /// عدد الوسطاء الموثوقين. 0 يعني تجاهل X-Forwarded-For.
  final int hops;

  final List<_IpNetwork> _networks;

  /// سبب رفض الإعداد، أو null إذا كان الإعداد صالحًا.
  final String? configError;

  bool get isEnabled => hops > 0 && _networks.isNotEmpty;

  bool trusts(InternetAddress address) =>
      _networks.any((network) => network.contains(address));
}

/// يحدد عنوان IP المعتمد في حدود OTP.
///
/// ترويستا Forwarded وX-Forwarded-For يرسلهما العميل نفسه، فيمكن تزويرهما
/// بقيمة جديدة في كل طلب وتجاوز حد العنوان. لذلك المصدر الموثوق الوحيد هو
/// عنوان اتصال TCP الفعلي ([socketAddress])، ولا تُقرأ X-Forwarded-For إلا إذا:
///
/// 1. كان عنوان الاتصال نفسه داخل نطاقات الوسطاء الموثوقين.
/// 2. كان كل وسيط بين الخادم والعميل (حسب [OtpTrustedProxies.hops]) داخل
///    هذه النطاقات أيضًا.
/// 3. كان العنوان الناتج عنوان IP صالحًا.
///
/// عندها نأخذ العنصر الذي ترتيبه `hops` من نهاية القائمة (العنوان الذي أضافه
/// أبعد وسيط موثوق)، لا الأول. في أي حالة أخرى نرجع لعنوان الاتصال.
String resolveOtpClientIp({
  required String socketAddress,
  required List<String> forwardedFor,
  OtpTrustedProxies trustedProxies = OtpTrustedProxies.none,
}) {
  final socket = _parseIp(socketAddress);

  // عنوان اتصال غير صالح لا يمكن أن يكون وسيطًا موثوقًا.
  if (socket == null) return socketAddress.trim();

  final hops = trustedProxies.hops;

  if (!trustedProxies.isEnabled ||
      forwardedFor.length < hops ||
      !trustedProxies.trusts(socket)) {
    return socket.address;
  }

  // الوسطاء بين الخادم والعميل، من الأقرب للخادم: عنوان الاتصال ثم آخر
  // (hops - 1) عناصر من الترويسة. يجب أن يكونوا كلهم موثوقين.
  for (var i = 1; i < hops; i++) {
    final proxy = _parseIp(forwardedFor[forwardedFor.length - i]);

    if (proxy == null || !trustedProxies.trusts(proxy)) {
      return socket.address;
    }
  }

  final client = _parseIp(forwardedFor[forwardedFor.length - hops]);

  return client?.address ?? socket.address;
}

/// يحلل عنوان IP ويعيده بصيغة موحدة (حتى لا ينتج العنوان نفسه أكثر من
/// بصمة)، ويحوّل IPv4 المضمّن في IPv6 (`::ffff:a.b.c.d`) إلى IPv4 حتى يطابق
/// نطاقات IPv4.
InternetAddress? _parseIp(String value) {
  final bytes = InternetAddress.tryParse(value.trim())?.rawAddress;

  if (bytes == null) return null;

  final isMappedIpv4 =
      bytes.length == 16 &&
      bytes.take(10).every((byte) => byte == 0) &&
      bytes[10] == 0xff &&
      bytes[11] == 0xff;

  return InternetAddress.fromRawAddress(
    isMappedIpv4 ? bytes.sublist(12) : bytes,
  );
}

class _IpNetwork {
  const _IpNetwork(this._bytes, this._prefixLength);

  final List<int> _bytes;
  final int _prefixLength;

  /// يقبل `a.b.c.d/n` أو `x:x::x/n`، أو عنوانًا مفردًا بلا بادئة.
  /// البادئة 0 مرفوضة لأنها تعني الثقة بكل العناوين.
  static _IpNetwork? tryParse(String cidr) {
    final parts = cidr.trim().split('/');

    if (parts.length > 2) return null;

    final address = InternetAddress.tryParse(parts.first);

    if (address == null) return null;

    final bytes = address.rawAddress;
    final maxPrefix = bytes.length * 8;

    final prefix = parts.length == 1
        ? maxPrefix
        : (RegExp(r'^\d{1,3}$').hasMatch(parts[1])
              ? int.parse(parts[1])
              : null);

    if (prefix == null || prefix < 1 || prefix > maxPrefix) return null;

    return _IpNetwork(bytes, prefix);
  }

  bool contains(InternetAddress address) {
    final other = address.rawAddress;

    if (other.length != _bytes.length) return false;

    final fullBytes = _prefixLength ~/ 8;
    final remainingBits = _prefixLength % 8;

    for (var i = 0; i < fullBytes; i++) {
      if (other[i] != _bytes[i]) return false;
    }

    if (remainingBits == 0) return true;

    final mask = (0xff << (8 - remainingBits)) & 0xff;

    return (other[fullBytes] & mask) == (_bytes[fullBytes] & mask);
  }
}
