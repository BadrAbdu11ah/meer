import 'dart:async';

import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/otp_rate_limit_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _hourlyLimit = 300;
const _dailyLimit = 1000;

// داخل نافذة الساعة.
const _withinHour = Duration(minutes: 5);

// خارج نافذة الساعة وداخل نافذة اليوم: يعزل الحد اليومي عن الحد الساعي.
const _withinDayOnly = Duration(hours: 2);

// خارج نافذة اليوم.
const _olderThanDay = Duration(hours: 25);

/// يسجل إرسالات سابقة مباشرة في الجدول بتاريخ قديم بدل انتظار وقت حقيقي.
/// كل صف له رقم وعنوان مختلفان حتى لا تُفعَّل حدود الرقم أو العنوان.
Future<void> _seedSends(
  Session session,
  int count, {
  required Duration age,
  String purpose = OtpRateLimitService.sendPurpose,
}) async {
  final createdAt = DateTime.now().toUtc().subtract(age);
  final tag = '${purpose}_${age.inSeconds}';

  await OtpAttempt.db.insert(
    session,
    [
      for (var i = 0; i < count; i++)
        OtpAttempt(
          phoneHash: 'seed-phone-$tag-$i',
          ipHash: 'seed-ip-$tag-$i',
          purpose: purpose,
          createdAt: createdAt,
        ),
    ],
  );
}

/// خدمة لكل طلب بعنوان IP مختلف، حتى يبقى الحد العام هو الحد الوحيد المؤثر.
OtpRateLimitService _serviceFor(int index) => OtpRateLimitService(
  clientIpResolver: (_) => '192.0.2.${index % 250 + 1}',
);

String _phoneFor(int index) => '9665${(10000000 + index).toString()}';

void main() {
  test('the default global send limits are 300 per hour and 1000 per day', () {
    const limits = OtpRateLimits();

    expect(
      {for (final rule in limits.sendGlobal) rule.window: rule.maxAttempts},
      {
        const Duration(hours: 1): _hourlyLimit,
        const Duration(hours: 24): _dailyLimit,
      },
    );

    // لا يجوز حذف صفوف ما زالت داخل أطول نافذة.
    final longestWindow = [
      ...limits.sendPhone,
      ...limits.sendIp,
      ...limits.sendGlobal,
      ...limits.verifyPhone,
      ...limits.verifyIp,
    ].map((rule) => rule.window).reduce((a, b) => a > b ? a : b);

    expect(limits.retentionPeriod, greaterThanOrEqualTo(longestWindow));
  });

  withServerpod(
    'Given the global OTP send limit',
    (sessionBuilder, _) {
      Future<bool> attempt(
        int index, {
        String purpose = OtpRateLimitService.sendPurpose,
      }) {
        return _serviceFor(index).allowAttempt(
          sessionBuilder.build(),
          phone: _phoneFor(index),
          purpose: purpose,
        );
      }

      test(
        'when 300 sends happened in the last hour then the next send is '
        'rejected',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit - 1,
            age: _withinHour,
          );

          // الإرسال رقم 300 مسموح، ورقم 301 مرفوض.
          expect(await attempt(1), isTrue);
          expect(await attempt(2), isFalse);
        },
      );

      test(
        'when the 300 sends are older than an hour then they no longer count '
        'against the hourly limit',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit,
            age: _withinDayOnly,
          );

          expect(await attempt(1), isTrue);
        },
      );

      test(
        'when 1000 sends happened in the last 24 hours then the next send is '
        'rejected even though the hourly limit is not reached',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit - 1,
            age: _withinDayOnly,
          );

          // لا يوجد أي إرسال داخل الساعة الأخيرة، فالرفض سببه الحد اليومي فقط.
          expect(await attempt(1), isTrue);
          expect(await attempt(2), isFalse);
        },
      );

      test(
        'when the 1000 sends are older than 24 hours then they no longer '
        'count against the daily limit',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit,
            age: _olderThanDay,
          );

          expect(await attempt(1), isTrue);
        },
      );

      test(
        'when the hourly and daily windows are both partly used then each is '
        'counted separately',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit - 1,
            age: _withinHour,
          );
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit - _hourlyLimit - 1,
            age: _withinDayOnly,
          );

          // المجموع اليومي 999 والساعي 299: طلب واحد فقط يملأ الحدين معًا.
          expect(await attempt(1), isTrue);
          expect(await attempt(2), isFalse);
        },
      );

      test(
        'when the global send limits are reached then verification is not '
        'affected',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit,
            age: _withinHour,
          );
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit,
            age: _withinDayOnly,
          );

          expect(await attempt(1), isFalse);
          expect(
            await attempt(2, purpose: OtpRateLimitService.verifyPurpose),
            isTrue,
          );
        },
      );

      test(
        'when many verifications happened then they do not consume the '
        'global send quota',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit,
            age: _withinHour,
            purpose: OtpRateLimitService.verifyPurpose,
          );

          expect(await attempt(1), isTrue);
        },
      );

      test(
        'when a send is rejected by the global limit then it is not recorded',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit,
            age: _withinHour,
          );

          expect(await attempt(1), isFalse);

          final recorded = await OtpAttempt.db.count(
            sessionBuilder.build(),
            where: (t) => t.purpose.equals(OtpRateLimitService.sendPurpose),
          );

          expect(recorded, _hourlyLimit);
        },
      );

      test(
        'when attempts are older than the retention period then they are '
        'deleted and newer ones are kept',
        () async {
          await _seedSends(sessionBuilder.build(), 5, age: _olderThanDay);
          await _seedSends(sessionBuilder.build(), 7, age: _withinDayOnly);

          expect(await attempt(1), isTrue);

          final remaining = await OtpAttempt.db.find(
            sessionBuilder.build(),
            where: (t) => t.phoneHash.like('seed-phone-%'),
          );

          expect(remaining, hasLength(7));

          final cutoff = DateTime.now().toUtc().subtract(
            const OtpRateLimits().retentionPeriod,
          );

          expect(
            remaining.every((attempt) => attempt.createdAt.isAfter(cutoff)),
            isTrue,
          );
        },
      );

      test(
        'when migrations are applied then the indexes used by the phone, IP, '
        'global and retention queries exist',
        () async {
          final rows = await sessionBuilder.build().db.unsafeQuery(
            'SELECT indexname FROM pg_indexes '
            "WHERE schemaname = current_schema() AND tablename = 'otp_attempt'",
          );

          expect(
            rows.map((row) => row.first),
            containsAll([
              'otp_attempt_phone_purpose_created_idx',
              'otp_attempt_ip_purpose_created_idx',
              'otp_attempt_purpose_created_idx',
              'otp_attempt_created_idx',
            ]),
          );
        },
      );

      test(
        'when custom limits are injected then they replace the defaults',
        () async {
          final service = OtpRateLimitService(
            clientIpResolver: (_) => '192.0.2.1',
            limits: const OtpRateLimits(
              sendGlobal: [OtpRateWindow(Duration(hours: 1), 2)],
            ),
          );

          Future<bool> send(int index) => service.allowAttempt(
            sessionBuilder.build(),
            phone: _phoneFor(index),
            purpose: OtpRateLimitService.sendPurpose,
          );

          expect(await send(1), isTrue);
          expect(await send(2), isTrue);
          expect(await send(3), isFalse);
        },
      );
    },
  );

  // Separate test group because concurrent transactions
  // are not supported when database rollback is enabled.
  withServerpod(
    'Given concurrent OTP sends near the global limit',
    (sessionBuilder, _) {
      const concurrentRequests = 12;

      Future<void> clearAttempts() async {
        await OtpAttempt.db.deleteWhere(
          sessionBuilder.build(),
          where: (t) => t.id > 0,
        );
      }

      setUp(clearAttempts);
      tearDown(clearAttempts);

      /// يطلق طلبات إرسال متزامنة، كل طلب برقم وعنوان مختلفين، فلا يجمعها
      /// إلا القفل العام.
      Future<List<bool>> sendConcurrently() async {
        final startGate = Completer<void>();

        final attempts = [
          for (var i = 0; i < concurrentRequests; i++)
            () async {
              final session = sessionBuilder.build();

              await startGate.future;

              return _serviceFor(i).allowAttempt(
                session,
                phone: _phoneFor(i),
                purpose: OtpRateLimitService.sendPurpose,
              );
            }(),
        ];

        startGate.complete();

        return Future.wait(attempts);
      }

      Future<int> countSends({required Duration within}) {
        final cutoff = DateTime.now().toUtc().subtract(within);

        return OtpAttempt.db.count(
          sessionBuilder.build(),
          where: (t) =>
              t.purpose.equals(OtpRateLimitService.sendPurpose) &
              (t.createdAt > cutoff),
        );
      }

      test(
        'when concurrent sends race for the last hourly slots then the hourly '
        'limit is not exceeded',
        () async {
          const freeSlots = 3;

          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit - freeSlots,
            age: _withinHour,
          );

          final results = await sendConcurrently();

          expect(results.where((allowed) => allowed), hasLength(freeSlots));
          expect(
            results.where((allowed) => !allowed),
            hasLength(concurrentRequests - freeSlots),
          );
          expect(
            await countSends(within: const Duration(hours: 1)),
            _hourlyLimit,
          );
        },
      );

      test(
        'when concurrent sends race for the last daily slots then the daily '
        'limit is not exceeded',
        () async {
          const freeSlots = 3;

          // كل الإرسالات السابقة خارج نافذة الساعة، فالحد اليومي وحده المؤثر.
          await _seedSends(
            sessionBuilder.build(),
            _dailyLimit - freeSlots,
            age: _withinDayOnly,
          );

          final results = await sendConcurrently();

          expect(results.where((allowed) => allowed), hasLength(freeSlots));
          expect(
            results.where((allowed) => !allowed),
            hasLength(concurrentRequests - freeSlots),
          );
          expect(
            await countSends(within: const Duration(hours: 24)),
            _dailyLimit,
          );
        },
      );

      test(
        'when concurrent verifications run while the send limit is full then '
        'all of them are allowed',
        () async {
          await _seedSends(
            sessionBuilder.build(),
            _hourlyLimit,
            age: _withinHour,
          );

          final results = await Future.wait([
            for (var i = 0; i < concurrentRequests; i++)
              _serviceFor(i).allowAttempt(
                sessionBuilder.build(),
                phone: _phoneFor(i),
                purpose: OtpRateLimitService.verifyPurpose,
              ),
          ]);

          expect(results, everyElement(isTrue));
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
