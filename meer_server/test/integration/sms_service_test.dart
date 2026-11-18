import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meer_server/src/services/sms_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given SMS service',
    (sessionBuilder, _) {
      const testApiKey = 'test-api-key';

      SmsService createService({
        required MockClient client,
        Duration timeout = const Duration(seconds: 15),
      }) {
        return SmsService(
          httpClient: client,
          requestTimeout: timeout,
          passwordResolver: (_, key) {
            switch (key) {
              case 'authenticaApiKey':
                return testApiKey;

              case 'authenticaTemplateId':
                return '5';

              default:
                return null;
            }
          },
        );
      }

      test(
        'when sending OTP successfully then it returns true',
        () async {
          late http.Request capturedRequest;

          final client = MockClient((request) async {
            capturedRequest = request;

            return http.Response(
              jsonEncode({
                'success': true,
                'message': 'OTP send successfully',
              }),
              200,
            );
          });

          addTearDown(client.close);

          final service = createService(client: client);

          final result = await service.sendOtp(
            sessionBuilder.build(),
            '0500000000',
          );

          expect(result, isTrue);

          expect(capturedRequest.method, 'POST');

          expect(
            capturedRequest.url.path,
            '/api/v2/send-otp',
          );

          expect(
            capturedRequest.headers['X-Authorization'],
            testApiKey,
          );

          final body =
              jsonDecode(
                    capturedRequest.body,
                  )
                  as Map<String, dynamic>;

          expect(body['phone'], '+966500000000');
          expect(body['method'], 'sms');
          expect(body['template_id'], 5);
        },
      );

      test(
        'when Authentica rejects sending OTP then it returns false',
        () async {
          final client = MockClient((request) async {
            return http.Response(
              jsonEncode({
                'success': false,
                'message': 'Failed to send OTP',
              }),
              200,
            );
          });

          addTearDown(client.close);

          final service = createService(client: client);

          final result = await service.sendOtp(
            sessionBuilder.build(),
            '0500000000',
          );

          expect(result, isFalse);
        },
      );

      test(
        'when Authentica returns a valid verification then it returns true',
        () async {
          late http.Request capturedRequest;

          final client = MockClient((request) async {
            capturedRequest = request;

            return http.Response(
              jsonEncode({
                'status': true,
                'message': 'OTP verified successfully',
              }),
              200,
            );
          });

          addTearDown(client.close);

          final service = createService(client: client);

          final result = await service.verifyOtp(
            sessionBuilder.build(),
            '0500000000',
            '123456',
          );

          expect(result, isTrue);

          expect(
            capturedRequest.url.path,
            '/api/v2/verify-otp',
          );

          final body =
              jsonDecode(
                    capturedRequest.body,
                  )
                  as Map<String, dynamic>;

          expect(body['phone'], '+966500000000');
          expect(body['otp'], '123456');
        },
      );

      test(
        'when OTP is invalid then it returns false',
        () async {
          final client = MockClient((request) async {
            return http.Response(
              jsonEncode({
                'status': false,
                'message': 'OTP verification failed',
              }),
              200,
            );
          });

          addTearDown(client.close);

          final service = createService(client: client);

          final result = await service.verifyOtp(
            sessionBuilder.build(),
            '0500000000',
            '000000',
          );

          expect(result, isFalse);
        },
      );

      test(
        'when Authentica request times out then it returns false',
        () async {
          final client = MockClient((request) {
            return Completer<http.Response>().future;
          });

          addTearDown(client.close);

          final service = createService(
            client: client,
            timeout: const Duration(milliseconds: 50),
          );

          final result = await service.sendOtp(
            sessionBuilder.build(),
            '0500000000',
          );

          expect(result, isFalse);
        },
      );
    },
  );
}
