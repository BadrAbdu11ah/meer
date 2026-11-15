import 'dart:async';

import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/otp_rate_limit_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given OTP rate limit service',
    (sessionBuilder, _) {
      const phone = '966500000101';
      const purpose = OtpRateLimitService.sendPurpose;

      late OtpRateLimitService service;

      setUp(() {
        service = OtpRateLimitService(
          clientIpResolver: (_) => '192.0.2.200',
        );
      });

      Future<void> seedAttempts({
        required String phone,
        required String purpose,
        required List<Duration> ages,
      }) async {
        final session = sessionBuilder.build();

        final allowed = await service.allowAttempt(
          session,
          phone: phone,
          purpose: purpose,
        );

        expect(allowed, isTrue);

        final seed = await OtpAttempt.db.findFirstRow(
          session,
          where: (t) => t.purpose.equals(purpose),
        );

        expect(seed, isNotNull);

        final now = DateTime.now().toUtc();

        seed!.createdAt = now.subtract(ages.first);
        await OtpAttempt.db.updateRow(session, seed);

        for (final age in ages.skip(1)) {
          await OtpAttempt.db.insertRow(
            session,
            OtpAttempt(
              phoneHash: seed.phoneHash,
              ipHash: seed.ipHash,
              purpose: purpose,
              createdAt: now.subtract(age),
            ),
          );
        }
      }

      test(
        'when sending the first OTP request then it is allowed',
        () async {
          final allowed = await service.allowAttempt(
            sessionBuilder.build(),
            phone: phone,
            purpose: purpose,
          );

          expect(allowed, isTrue);
        },
      );

      test(
        'when sending a second OTP request within 60 seconds then it is rejected',
        () async {
          final session = sessionBuilder.build();

          final firstAttempt = await service.allowAttempt(
            session,
            phone: phone,
            purpose: purpose,
          );

          final secondAttempt = await service.allowAttempt(
            session,
            phone: phone,
            purpose: purpose,
          );

          expect(firstAttempt, isTrue);
          expect(secondAttempt, isFalse);
        },
      );

      test(
        'when the 60-second window expires then another request is allowed',
        () async {
          final session = sessionBuilder.build();

          final firstAttempt = await service.allowAttempt(
            session,
            phone: phone,
            purpose: purpose,
          );

          expect(firstAttempt, isTrue);

          final attempt = await OtpAttempt.db.findFirstRow(
            session,
            where: (t) => t.purpose.equals(purpose),
          );

          expect(attempt, isNotNull);

          attempt!.createdAt = DateTime.now().toUtc().subtract(
            const Duration(minutes: 2),
          );

          await OtpAttempt.db.updateRow(session, attempt);

          final secondAttempt = await service.allowAttempt(
            session,
            phone: phone,
            purpose: purpose,
          );

          expect(secondAttempt, isTrue);
        },
      );

      test(
        'when 3 attempts exist within 15 minutes then another is rejected',
        () async {
          await seedAttempts(
            phone: phone,
            purpose: OtpRateLimitService.sendPurpose,
            ages: const [
              Duration(minutes: 14),
              Duration(minutes: 8),
              Duration(minutes: 2),
            ],
          );

          final allowed = await service.allowAttempt(
            sessionBuilder.build(),
            phone: phone,
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(allowed, isFalse);
        },
      );

      test(
        'when 8 attempts exist within 24 hours then another is rejected',
        () async {
          await seedAttempts(
            phone: phone,
            purpose: OtpRateLimitService.sendPurpose,
            ages: const [
              Duration(hours: 23),
              Duration(hours: 20),
              Duration(hours: 17),
              Duration(hours: 14),
              Duration(hours: 11),
              Duration(hours: 8),
              Duration(hours: 5),
              Duration(minutes: 20),
            ],
          );

          final allowed = await service.allowAttempt(
            sessionBuilder.build(),
            phone: phone,
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(allowed, isFalse);
        },
      );

      test(
        'when 5 verification attempts exist within 10 minutes then another is rejected',
        () async {
          await seedAttempts(
            phone: phone,
            purpose: OtpRateLimitService.verifyPurpose,
            ages: const [
              Duration(minutes: 9),
              Duration(minutes: 7),
              Duration(minutes: 5),
              Duration(minutes: 3),
              Duration(minutes: 2),
            ],
          );

          final allowed = await service.allowAttempt(
            sessionBuilder.build(),
            phone: phone,
            purpose: OtpRateLimitService.verifyPurpose,
          );

          expect(allowed, isFalse);
        },
      );

      test(
        'when 21 different phones send OTP from the same IP then the 21st request is rejected',
        () async {
          const sharedIpAddress = '192.0.2.10';

          final ipService = OtpRateLimitService(
            clientIpResolver: (_) => sharedIpAddress,
          );

          for (var i = 0; i < 20; i++) {
            final testPhone = '966500000${i.toString().padLeft(3, '0')}';

            final allowed = await ipService.allowAttempt(
              sessionBuilder.build(),
              phone: testPhone,
              purpose: OtpRateLimitService.sendPurpose,
            );

            expect(
              allowed,
              isTrue,
              reason: 'Request ${i + 1} should be allowed.',
            );
          }

          final blocked = await ipService.allowAttempt(
            sessionBuilder.build(),
            phone: '966500000999',
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(blocked, isFalse);
        },
      );

      test(
        'when 40 different phones verify from the same IP then the 41st attempt is rejected',
        () async {
          const sharedIpAddress = '192.0.2.40';

          final ipService = OtpRateLimitService(
            clientIpResolver: (_) => sharedIpAddress,
          );

          for (var i = 0; i < 40; i++) {
            final testPhone = '966500000${i.toString().padLeft(3, '0')}';

            final allowed = await ipService.allowAttempt(
              sessionBuilder.build(),
              phone: testPhone,
              purpose: OtpRateLimitService.verifyPurpose,
            );

            expect(
              allowed,
              isTrue,
              reason: 'Verification attempt ${i + 1} should be allowed.',
            );
          }

          final blocked = await ipService.allowAttempt(
            sessionBuilder.build(),
            phone: '966500000999',
            purpose: OtpRateLimitService.verifyPurpose,
          );

          expect(blocked, isFalse);
        },
      );

      test(
        'when 100 different phones send OTP from the same IP within 24 hours then the 101st request is rejected',
        () async {
          const sharedIpAddress = '192.0.2.100';

          final ipService = OtpRateLimitService(
            clientIpResolver: (_) => sharedIpAddress,
          );

          final session = sessionBuilder.build();

          final firstAllowed = await ipService.allowAttempt(
            session,
            phone: '966500000900',
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(firstAllowed, isTrue);

          final seed = await OtpAttempt.db.findFirstRow(
            session,
            where: (t) => t.purpose.equals(OtpRateLimitService.sendPurpose),
          );

          expect(seed, isNotNull);

          final now = DateTime.now().toUtc();

          seed!.createdAt = now.subtract(
            const Duration(minutes: 20),
          );

          await OtpAttempt.db.updateRow(session, seed);

          for (var i = 1; i < 100; i++) {
            await OtpAttempt.db.insertRow(
              session,
              OtpAttempt(
                phoneHash: 'test-phone-hash-$i',
                ipHash: seed.ipHash,
                purpose: OtpRateLimitService.sendPurpose,
                createdAt: now.subtract(
                  Duration(minutes: 20 + (i * 10)),
                ),
              ),
            );
          }

          final blocked = await ipService.allowAttempt(
            sessionBuilder.build(),
            phone: '966500000901',
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(blocked, isFalse);
        },
      );
    },
  );

  // Separate test group because concurrent transactions
  // are not supported when database rollback is enabled.
  withServerpod(
    'Given concurrent OTP rate limit requests',
    (sessionBuilder, _) {
      final service = OtpRateLimitService(
        clientIpResolver: (_) => '192.0.2.199',
      );

      test(
        'when 5 OTP requests arrive concurrently for the same phone then only one is allowed',
        () async {
          const concurrentPhone = '966500000199';

          final sessions = List.generate(
            5,
            (_) => sessionBuilder.build(),
          );

          final startGate = Completer<void>();

          final attempts = sessions.map((session) async {
            await startGate.future;

            return service.allowAttempt(
              session,
              phone: concurrentPhone,
              purpose: OtpRateLimitService.sendPurpose,
            );
          }).toList();

          startGate.complete();

          final results = await Future.wait(attempts);

          final allowedCount = results.where((r) => r).length;
          final rejectedCount = results.where((r) => !r).length;

          expect(allowedCount, 1);
          expect(rejectedCount, 4);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
