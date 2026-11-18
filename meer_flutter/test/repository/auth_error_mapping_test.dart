import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/repository/auth_repository.dart';

void main() {
  group('Given a typed server error', () {
    const expected = {
      'OTP_RATE_LIMITED':
          'محاولات كثيرة. يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.',
      'INVALID_PHONE_OTP': 'رمز التحقق غير صحيح أو انتهت صلاحيته.',
      'INVALID_PHONE_FORMAT': 'صيغة رقم الهاتف غير صحيحة.',
      'PHONE_ALREADY_IN_USE': 'رقم الهاتف مرتبط بحساب آخر.',
      'ACCOUNT_ALREADY_HAS_PHONE':
          'هذا الحساب مرتبط برقم هاتف آخر، ولا يمكن تغييره من هنا.',
    };

    for (final MapEntry(key: code, value: message) in expected.entries) {
      test('when the code is $code then its Arabic message is shown', () {
        for (final action in AuthAction.values) {
          final failure = mapAuthError(
            // رسالة الخادم لا تُعرض، فالنص يُختار من الرمز فقط.
            MeerException(code: code, message: 'SERVER TEXT'),
            action,
          );

          expect(failure, isA<AuthFailure>(), reason: '$action');
          expect(failure.message, message, reason: '$action');
        }
      });
    }

    test(
      'when the error travels over the Serverpod protocol then it is decoded '
      'as a MeerException with the same code',
      () {
        final protocol = Protocol();

        for (final code in expected.keys) {
          // نفس صيغة رد الخادم (HTTP 400) لأي SerializableException.
          final body = jsonEncode({
            'className': 'MeerException',
            'data': {
              '__className__': 'MeerException',
              'code': code,
              'message': 'نص من الخادم',
            },
          });

          final decoded = protocol.decodeWithType(body);

          expect(decoded, isA<SerializableException>());
          expect(decoded, isA<MeerException>());
          expect((decoded! as MeerException).code, code);
          expect(
            mapAuthError(decoded, AuthAction.sendOtp).message,
            expected[code],
          );
        }
      },
    );

    test(
      'when the client encodes a MeerException then the server wire format '
      'is produced',
      () {
        final body = Protocol().encodeWithType(
          MeerException(code: 'OTP_RATE_LIMITED', message: 'x'),
        );

        expect(jsonDecode(body), {
          'className': 'MeerException',
          'data': {
            '__className__': 'MeerException',
            'code': 'OTP_RATE_LIMITED',
            'message': 'x',
          },
        });
      },
    );
  });

  group('Given an unknown or internal error', () {
    const secret = 'PostgreSQLException: relation "otp_attempt" at 10.0.0.5';

    final unknownErrors = <Object>[
      MeerException(code: 'SOME_FUTURE_CODE', message: secret),
      MeerException(code: '', message: secret),
      Exception(secret),
      StateError(secret),
      FormatException(secret),
      ServerpodClientInternalServerError(),
      ServerpodClientBadRequest(secret),
      ServerpodClientUnauthorized(),
      const ServerpodClientUnknownException(secret),
      secret,
    ];

    test('when it is mapped then a safe generic message is shown', () {
      const generic = {
        AuthAction.googleSignIn: 'تعذر تسجيل الدخول. حاول مرة أخرى.',
        AuthAction.sendOtp:
            'تعذر إرسال رمز التحقق حاليًا. يرجى المحاولة بعد قليل.',
        AuthAction.verifyOtp: 'تعذر إتمام تسجيل الدخول. حاول مرة أخرى.',
        AuthAction.linkPhone: 'تعذر توثيق رقم الهاتف. حاول مرة أخرى.',
      };

      for (final action in AuthAction.values) {
        for (final error in unknownErrors) {
          final failure = mapAuthError(error, action);

          expect(failure, isA<ServerFailure>(), reason: '$action / $error');
          expect(failure.message, generic[action], reason: '$action / $error');
        }
      }
    });

    test('when it is mapped then no exception text reaches the user', () {
      for (final action in AuthAction.values) {
        for (final error in [
          ...unknownErrors,
          const ServerpodClientNetworkException(secret),
          SocketException(secret),
        ]) {
          final message = mapAuthError(error, action).message;

          expect(message, isNot(contains('PostgreSQL')), reason: '$error');
          expect(message, isNot(contains('10.0.0.5')), reason: '$error');
          expect(message, isNot(contains('Exception')), reason: '$error');
          expect(message, isNot(contains('SOME_FUTURE_CODE')));
        }
      }
    });
  });

  group('Given a failed OTP send', () {
    test('when the network is unreachable then a connection message is '
        'shown', () {
      for (final action in AuthAction.values) {
        final failure = mapAuthError(
          const ServerpodClientNetworkException('SocketException: refused'),
          action,
        );

        expect(failure, isA<OfflineFailure>());
        expect(
          failure.message,
          'تعذر الاتصال بالخادم. تحقق من اتصالك بالإنترنت ثم حاول مرة أخرى.',
        );
      }
    });

    test('when the cause differs then each kind gets a different message', () {
      final messages = {
        'rate limit': mapAuthError(
          MeerException(code: 'OTP_RATE_LIMITED', message: ''),
          AuthAction.sendOtp,
        ).message,
        'invalid phone': mapAuthError(
          MeerException(code: 'INVALID_PHONE_FORMAT', message: ''),
          AuthAction.sendOtp,
        ).message,
        'sms provider': smsSendFailedMessage,
        'network': mapAuthError(
          const ServerpodClientNetworkException(''),
          AuthAction.sendOtp,
        ).message,
      };

      expect(messages.values.toSet(), hasLength(messages.length));
    });

    test('when the SMS provider fails then the user is not told that the '
        'phone number is wrong', () {
      expect(smsSendFailedMessage, isNot(contains('الرقم')));
      expect(smsSendFailedMessage, isNot(contains('الهاتف')));
      expect(smsSendFailedMessage, contains('تعذر إرسال رمز التحقق'));
    });
  });
}
