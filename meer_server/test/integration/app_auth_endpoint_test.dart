import 'dart:async';

import 'package:meer_server/src/auth/phone_otp_idp_config.dart';
import 'package:meer_server/src/endpoints/app_auth_endpoint.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/otp_rate_limit_service.dart';
import 'package:meer_server/src/services/sms_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given AppAuthEndpoint',
    (sessionBuilder, _) {
      late _FakeSmsService smsService;
      late _FakeRateLimitService rateLimitService;
      late AppAuthEndpoint endpoint;

      setUp(() {
        smsService = _FakeSmsService();
        rateLimitService = _FakeRateLimitService();

        endpoint = AppAuthEndpoint(
          smsService: smsService,
          rateLimitService: rateLimitService,
        );
      });
      setUpAll(() {
        AuthServices.set(
          tokenManagerBuilders: [
            JwtConfigFromPasswords(),
          ],
          identityProviderBuilders: [
            PhoneOtpIdpConfig(),
          ],
        );
      });

      group('sendOtp', () {
        test(
          'when phone format is invalid then request is rejected',
          () async {
            final result = await endpoint.sendOtp(
              sessionBuilder.build(),
              'invalid-phone',
            );

            expect(result, isFalse);
            expect(rateLimitService.calls, 0);
            expect(smsService.sendCalls, 0);
          },
        );

        test(
          'when rate limit rejects request then SMS is not sent',
          () async {
            rateLimitService.allowed = false;

            final result = await endpoint.sendOtp(
              sessionBuilder.build(),
              '0501234567',
            );

            expect(result, isFalse);
            expect(rateLimitService.calls, 1);
            expect(
              rateLimitService.lastPurpose,
              OtpRateLimitService.sendPurpose,
            );
            expect(smsService.sendCalls, 0);
          },
        );

        test(
          'when rate limit allows request then SMS is sent',
          () async {
            final result = await endpoint.sendOtp(
              sessionBuilder.build(),
              '0501234567',
            );

            expect(result, isTrue);
            expect(rateLimitService.calls, 1);
            expect(smsService.sendCalls, 1);
            expect(smsService.lastPhone, '966501234567');
          },
        );
      });

      group('verifyOtp', () {
        test(
          'when a new phone is verified then an account and profile are created',
          () async {
            const phone = '966500000501';

            final session = sessionBuilder.build();

            final result = await endpoint.verifyOtp(
              session,
              phone,
              '123456',
            );

            // التأكد من إصدار جلسة المصادقة.
            expect(result, isA<AuthSuccess>());

            // التأكد من إنشاء حساب الهاتف.
            final account = await PhoneAuthAccount.db.findFirstRow(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(account, isNotNull);

            // التأكد من إنشاء ملف المستخدم في مِيْر.
            final profile = await MeerUserProfile.db.findFirstRow(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(profile, isNotNull);
            expect(profile!.authUserId, account!.authUserId);

            expect(smsService.verifyCalls, 1);
            expect(
              rateLimitService.lastPurpose,
              OtpRateLimitService.verifyPurpose,
            );
          },
        );
        test(
          'when an existing phone is verified then the existing account is reused',
          () async {
            const phone = '966500000502';

            final session = sessionBuilder.build();

            // إنشاء حساب مصادقة موجود مسبقًا.
            final authUser = await const AuthUsers().create(session);

            await PhoneAuthAccount.db.insertRow(
              session,
              PhoneAuthAccount(
                authUserId: authUser.id,
                phone: phone,
                createdAt: DateTime.now().toUtc(),
              ),
            );

            // تسجيل الدخول باستخدام رقم الهاتف نفسه.
            final result = await endpoint.verifyOtp(
              session,
              phone,
              '123456',
            );

            expect(result, isA<AuthSuccess>());

            // التأكد من عدم إنشاء ربط جديد للرقم.
            final accounts = await PhoneAuthAccount.db.count(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(accounts, 1);

            // التأكد من ارتباط ملف مِيْر بالحساب الأصلي.
            final profile = await MeerUserProfile.db.findFirstRow(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(profile, isNotNull);
            expect(profile!.authUserId, authUser.id);
          },
        );
        test(
          'when phone format is invalid then verification is rejected',
          () async {
            await expectLater(
              endpoint.verifyOtp(
                sessionBuilder.build(),
                'invalid-phone',
                '123456',
              ),
              throwsA(isA<Exception>()),
            );

            expect(rateLimitService.calls, 0);
            expect(smsService.verifyCalls, 0);
          },
        );

        test(
          'when rate limit rejects verification then Authentica is not called',
          () async {
            rateLimitService.allowed = false;

            await expectLater(
              endpoint.verifyOtp(
                sessionBuilder.build(),
                '0501234567',
                '123456',
              ),
              throwsA(isA<Exception>()),
            );

            expect(rateLimitService.calls, 1);
            expect(
              rateLimitService.lastPurpose,
              OtpRateLimitService.verifyPurpose,
            );
            expect(smsService.verifyCalls, 0);
          },
        );

        test(
          'when Authentica rejects OTP then verification fails',
          () async {
            smsService.verifyResult = false;

            await expectLater(
              endpoint.verifyOtp(
                sessionBuilder.build(),
                '0501234567',
                '000000',
              ),
              throwsA(isA<Exception>()),
            );

            expect(rateLimitService.calls, 1);
            expect(smsService.verifyCalls, 1);
            expect(smsService.lastOtp, '000000');
          },
        );
        test(
          'when phone belongs to an existing Google account then automatic linking is rejected',
          () async {
            const phone = '966500000504';

            final session = sessionBuilder.build();

            // إنشاء حساب Google تجريبي.
            final googleUser = await const AuthUsers().create(session);

            // إنشاء ملف مِيْر المرتبط بحساب Google.
            await MeerUserProfile.db.insertRow(
              session,
              MeerUserProfile(
                authUserId: googleUser.id,
                fullName: 'Google Test User',
                phone: phone,
                role: 'customer',
                isSeller: false,
                storeName: null,
                storeAddress: null,
                storeCity: null,
                offersDelivery: false,
                deliveryFee: 0,
                createdAt: DateTime.now().toUtc(),
              ),
            );

            // محاولة تسجيل الدخول عبر الهاتف.
            await expectLater(
              endpoint.verifyOtp(
                session,
                phone,
                '123456',
              ),
              throwsA(isA<StateError>()),
            );

            // يجب ألا يُنشأ ربط هاتف تلقائي.
            final accountCount = await PhoneAuthAccount.db.count(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(accountCount, 0);
            expect(smsService.verifyCalls, 1);
          },
        );
      });

      group('linkVerifiedPhone', () {
        test(
          'when a verified phone is linked then the profile and phone account are updated',
          () async {
            const phone = '966500000503';

            final session = sessionBuilder.build();

            // إنشاء مستخدم مصادق عليه.
            final authUser = await const AuthUsers().create(session);

            // إنشاء ملف مِيْر بدون رقم هاتف.
            await MeerUserProfile.db.insertRow(
              session,
              MeerUserProfile(
                authUserId: authUser.id,
                fullName: 'OTP Test User',
                phone: '',
                role: 'customer',
                isSeller: false,
                storeName: null,
                storeAddress: null,
                storeCity: null,
                offersDelivery: false,
                deliveryFee: 0,
                createdAt: DateTime.now().toUtc(),
              ),
            );

            final authenticatedSession = sessionBuilder
                .copyWith(
                  authentication: AuthenticationOverride.authenticationInfo(
                    authUser.id.toString(),
                    {},
                  ),
                )
                .build();

            // تنفيذ ربط الهاتف.
            final result = await endpoint.linkVerifiedPhone(
              authenticatedSession,
              phone,
              '123456',
            );

            expect(result.phone, phone);
            expect(result.authUserId, authUser.id);

            // التأكد من إنشاء سجل الربط.
            final account = await PhoneAuthAccount.db.findFirstRow(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(account, isNotNull);
            expect(account!.authUserId, authUser.id);

            expect(smsService.verifyCalls, 1);
          },
        );
        test(
          'when user is not authenticated then linking is rejected',
          () async {
            await expectLater(
              endpoint.linkVerifiedPhone(
                sessionBuilder.build(),
                '0501234567',
                '123456',
              ),
              throwsA(isA<Exception>()),
            );

            expect(rateLimitService.calls, 0);
            expect(smsService.verifyCalls, 0);
          },
        );

        test(
          'when rate limit rejects linking then Authentica is not called',
          () async {
            rateLimitService.allowed = false;

            final authUser = await const AuthUsers().create(
              sessionBuilder.build(),
            );

            final authenticatedSession = sessionBuilder
                .copyWith(
                  authentication: AuthenticationOverride.authenticationInfo(
                    authUser.id.toString(),
                    {},
                  ),
                )
                .build();

            await expectLater(
              endpoint.linkVerifiedPhone(
                authenticatedSession,
                '0501234567',
                '123456',
              ),
              throwsA(isA<Exception>()),
            );

            expect(rateLimitService.calls, 1);
            expect(
              rateLimitService.lastPurpose,
              OtpRateLimitService.verifyPurpose,
            );
            expect(smsService.verifyCalls, 0);
          },
        );
        test(
          'when phone belongs to another account then linking is rejected',
          () async {
            const phone = '966500000505';

            final session = sessionBuilder.build();

            // إنشاء صاحب الحساب الحالي.
            final currentUser = await const AuthUsers().create(session);

            // إنشاء صاحب رقم الهاتف.
            final existingUser = await const AuthUsers().create(session);

            // إنشاء ملف المستخدم الحالي دون رقم هاتف.
            await MeerUserProfile.db.insertRow(
              session,
              MeerUserProfile(
                authUserId: currentUser.id,
                fullName: 'Current Test User',
                phone: '',
                role: 'customer',
                isSeller: false,
                storeName: null,
                storeAddress: null,
                storeCity: null,
                offersDelivery: false,
                deliveryFee: 0,
                createdAt: DateTime.now().toUtc(),
              ),
            );

            // ربط الرقم بحساب آخر مسبقًا.
            await PhoneAuthAccount.db.insertRow(
              session,
              PhoneAuthAccount(
                authUserId: existingUser.id,
                phone: phone,
                createdAt: DateTime.now().toUtc(),
              ),
            );

            final authenticatedSession = sessionBuilder
                .copyWith(
                  authentication: AuthenticationOverride.authenticationInfo(
                    currentUser.id.toString(),
                    {},
                  ),
                )
                .build();

            await expectLater(
              endpoint.linkVerifiedPhone(
                authenticatedSession,
                phone,
                '123456',
              ),
              throwsA(
                predicate(
                  (error) => error.toString().contains('PHONE_ALREADY_IN_USE'),
                ),
              ),
            );

            // التأكد من بقاء الرقم مرتبطًا بصاحبه الأصلي.
            final account = await PhoneAuthAccount.db.findFirstRow(
              session,
              where: (t) => t.phone.equals(phone),
            );

            expect(account, isNotNull);
            expect(account!.authUserId, existingUser.id);

            // التأكد من عدم تعديل ملف المستخدم الحالي.
            final profile = await MeerUserProfile.db.findFirstRow(
              session,
              where: (t) => t.authUserId.equals(currentUser.id),
            );

            expect(profile, isNotNull);
            expect(profile!.phone, '');

            expect(smsService.verifyCalls, 1);
          },
        );
      });
    },
  );
  withServerpod(
    'Given concurrent phone linking requests',
    (sessionBuilder, _) {
      late AppAuthEndpoint endpoint;

      setUp(() {
        endpoint = AppAuthEndpoint(
          smsService: _FakeSmsService(),
          rateLimitService: _FakeRateLimitService(),
        );
      });

      test(
        'when two users link the same phone concurrently then only one succeeds',
        () async {
          const phone = '0501234567';

          final setupSession = sessionBuilder.build();

          // إنشاء المستخدم الأول.
          final userA = await const AuthUsers().create(
            setupSession,
          );

          // إنشاء المستخدم الثاني.
          final userB = await const AuthUsers().create(
            setupSession,
          );

          // إنشاء ملف مِيْر للمستخدم الأول.
          await MeerUserProfile.db.insertRow(
            setupSession,
            MeerUserProfile(
              authUserId: userA.id,
              fullName: 'User A',
              phone: '',
              role: 'customer',
              isSeller: false,
              storeName: null,
              storeAddress: null,
              storeCity: null,
              offersDelivery: false,
              deliveryFee: 0,
              createdAt: DateTime.now().toUtc(),
            ),
          );

          // إنشاء ملف مِيْر للمستخدم الثاني.
          await MeerUserProfile.db.insertRow(
            setupSession,
            MeerUserProfile(
              authUserId: userB.id,
              fullName: 'User B',
              phone: '',
              role: 'customer',
              isSeller: false,
              storeName: null,
              storeAddress: null,
              storeCity: null,
              offersDelivery: false,
              deliveryFee: 0,
              createdAt: DateTime.now().toUtc(),
            ),
          );

          // إنشاء جلسة المستخدم الأول.
          final sessionA = sessionBuilder
              .copyWith(
                authentication: AuthenticationOverride.authenticationInfo(
                  userA.id.toString(),
                  {},
                ),
              )
              .build();

          // إنشاء جلسة المستخدم الثاني.
          final sessionB = sessionBuilder
              .copyWith(
                authentication: AuthenticationOverride.authenticationInfo(
                  userB.id.toString(),
                  {},
                ),
              )
              .build();

          // حاجز لإطلاق الطلبين معًا.
          final startGate = Completer<void>();

          Future<Object> linkPhone(Session session) async {
            await startGate.future;

            try {
              return await endpoint.linkVerifiedPhone(
                session,
                phone,
                '123456',
              );
            } catch (error) {
              return error;
            }
          }

          final requests = [
            linkPhone(sessionA),
            linkPhone(sessionB),
          ];

          startGate.complete();

          final results = await Future.wait(requests);

          // يجب أن ينجح طلب واحد فقط.
          final successes = results.whereType<MeerUserProfile>().toList();

          final failures = results
              .where((result) => result is! MeerUserProfile)
              .toList();

          expect(successes.length, 1);
          expect(failures.length, 1);

          expect(
            failures.single.toString(),
            contains('PHONE_ALREADY_IN_USE'),
          );

          // التحقق من ملكية الرقم في قاعدة البيانات.
          final verificationSession = sessionBuilder.build();

          final account = await PhoneAuthAccount.db.findFirstRow(
            verificationSession,
            where: (t) => t.phone.equals('966501234567'),
          );

          expect(account, isNotNull);

          expect(
            account!.authUserId,
            anyOf(userA.id, userB.id),
          );

          // التأكد من أن ملف مستخدم واحد فقط يحمل الرقم.
          final profileA = await MeerUserProfile.db.findFirstRow(
            verificationSession,
            where: (t) => t.authUserId.equals(userA.id),
          );

          final profileB = await MeerUserProfile.db.findFirstRow(
            verificationSession,
            where: (t) => t.authUserId.equals(userB.id),
          );

          final linkedProfiles =
              [
                profileA,
                profileB,
              ].where(
                (profile) => profile?.phone == '966501234567',
              );

          expect(linkedProfiles.length, 1);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

// Fake SMS service used in tests.
class _FakeSmsService extends SmsService {
  bool sendResult = true;
  bool verifyResult = true;

  int sendCalls = 0;
  int verifyCalls = 0;

  String? lastPhone;
  String? lastOtp;

  @override
  Future<bool> sendOtp(Session session, String phone) async {
    sendCalls++;
    lastPhone = phone;

    return sendResult;
  }

  @override
  Future<bool> verifyOtp(
    Session session,
    String phone,
    String otp,
  ) async {
    verifyCalls++;
    lastPhone = phone;
    lastOtp = otp;

    return verifyResult;
  }
}

// Fake Rate Limit service used in tests.
class _FakeRateLimitService extends OtpRateLimitService {
  bool allowed = true;

  int calls = 0;

  String? lastPurpose;
  String? lastPhone;

  @override
  Future<bool> allowAttempt(
    Session session, {
    required String phone,
    required String purpose,
  }) async {
    calls++;
    lastPhone = phone;
    lastPurpose = purpose;

    return allowed;
  }
}
