import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

class PhoneAuthAccountLock {
  /// قفل خاص برقم الهاتف.
  static Future<void> acquirePhone({
    required Session session,
    required Transaction transaction,
    required String phone,
  }) async {
    final normalizedPhone = phone.replaceAll(
      RegExp(r'\D'),
      '',
    );

    if (normalizedPhone.isEmpty) {
      throw FormatException('رقم الهاتف غير صالح.');
    }

    await _acquire(
      session: session,
      transaction: transaction,
      namespace: 'phone',
      value: normalizedPhone,
    );
  }

  /// قفل خاص بحساب المستخدم.
  static Future<void> acquireUser({
    required Session session,
    required Transaction transaction,
    required String authUserId,
  }) async {
    if (authUserId.trim().isEmpty) {
      throw ArgumentError('authUserId cannot be empty.');
    }

    await _acquire(
      session: session,
      transaction: transaction,
      namespace: 'user',
      value: authUserId.trim(),
    );
  }

  static Future<void> _acquire({
    required Session session,
    required Transaction transaction,
    required String namespace,
    required String value,
  }) async {
    // عدم تمرير رقم الهاتف أو معرف المستخدم مباشرة إلى مفتاح القفل.
    final digest = sha256.convert(utf8.encode(value)).toString();

    final lockKey = 'phone-auth-account:$namespace:$digest';

    await session.db.unsafeQuery(
      'SELECT pg_advisory_xact_lock('
      'hashtextextended(@lockKey, 0))',
      parameters: QueryParameters.named({
        'lockKey': lockKey,
      }),
      transaction: transaction,
    );
  }
}
