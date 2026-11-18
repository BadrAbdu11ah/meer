import 'dart:async';
import 'dart:convert';

import 'package:meer_server/src/auth/auth_errors.dart';
import 'package:meer_server/src/auth/phone_otp_idp_config.dart';
import 'package:meer_server/src/endpoints/app_auth_endpoint.dart';
import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/otp_rate_limit_service.dart';
import 'package:meer_server/src/services/sms_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// يتحقق أن الخطأ MeerException قابل للإرسال للعميل وبالرمز المتوقع.
Matcher throwsMeerException(String code) => throwsA(
  isA<MeerException>()
      .having((e) => e, 'serializable', isA<SerializableException>())
      .having((e) => e.code, 'code', code)
      .having((e) => e.message.trim(), 'message', isNotEmpty),
);

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

      /// ينشئ مستخدمًا مصادقًا عليه مع ملف مِيْر، ويعيد جلسته.
      Future<Session> authenticatedSessionWithProfile({
        String phone = '',
      }) async {
        final session = sessionBuilder.build();
        final authUser = await const AuthUsers().create(session);

        await MeerUserProfile.db.insertRow(
          session,
          MeerUserProfile(
            authUserId: authUser.id,
            fullName: 'OTP Test User',
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

        return sessionBuilder
            .copyWith(
              authentication: AuthenticationOverride.authenticationInfo(
                authUser.id.toString(),
                {},
              ),
            )
            .build();
      }

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
            for (final phone in ['invalid-phone', '', '   ', '0412345678']) {
              await expectLater(
                endpoint.sendOtp(sessionBuilder.build(), phone),
                throwsMeerException('INVALID_PHONE_FORMAT'),
                reason: 'phone: "$phone"',
              );
            }

            expect(rateLimitService.calls, 0);
            expect(smsService.sendCalls, 0);
          },
        );

        test(
          'when the SMS provider fails then false is returned instead of an '
          'invalid phone error',
          () async {
            smsService.sendResult = false;

            final result = await endpoint.sendOtp(
              sessionBuilder.build(),
              '0501234567',
            );

            expect(result, isFalse);
            expect(rateLimitService.calls, 1);
            expect(smsService.sendCalls, 1);
          },
        );

        test(
          'when rate limit rejects request then SMS is not sent',
          () async {
            rateLimitService.allowed = false;

            await expectLater(
              endpoint.sendOtp(
                sessionBuilder.build(),
                '0501234567',
              ),
              throwsMeerException('OTP_RATE_LIMITED'),
            );

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
              throwsMeerException('INVALID_PHONE_FORMAT'),
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
              throwsMeerException('OTP_RATE_LIMITED'),
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
              throwsMeerException('INVALID_PHONE_OTP'),
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
              throwsMeerException('OTP_RATE_LIMITED'),
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
              throwsMeerException('PHONE_ALREADY_IN_USE'),
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

        test(
          'when phone format is invalid then linking is rejected',
          () async {
            final session = await authenticatedSessionWithProfile();

            await expectLater(
              endpoint.linkVerifiedPhone(session, 'invalid-phone', '123456'),
              throwsMeerException('INVALID_PHONE_FORMAT'),
            );

            expect(rateLimitService.calls, 0);
            expect(smsService.verifyCalls, 0);
          },
        );

        test(
          'when the code is empty or rejected by Authentica then linking '
          'fails with an invalid OTP error',
          () async {
            final session = await authenticatedSessionWithProfile();

            await expectLater(
              endpoint.linkVerifiedPhone(session, '0501234567', '  '),
              throwsMeerException('INVALID_PHONE_OTP'),
            );

            expect(rateLimitService.calls, 0);

            smsService.verifyResult = false;

            await expectLater(
              endpoint.linkVerifiedPhone(session, '0501234567', '000000'),
              throwsMeerException('INVALID_PHONE_OTP'),
            );

            expect(rateLimitService.calls, 1);
            expect(smsService.verifyCalls, 1);
          },
        );

        test(
          'when the account already has a different phone then linking is '
          'rejected',
          () async {
            final session = await authenticatedSessionWithProfile(
              phone: '966500000601',
            );

            await expectLater(
              endpoint.linkVerifiedPhone(session, '0500000602', '123456'),
              throwsMeerException('ACCOUNT_ALREADY_HAS_PHONE'),
            );

            final account = await PhoneAuthAccount.db.findFirstRow(
              sessionBuilder.build(),
              where: (t) => t.phone.equals('966500000602'),
            );

            expect(account, isNull);
          },
        );
      });

      group('with the real OTP rate limiter', () {
        late AppAuthEndpoint protectedEndpoint;

        setUp(() {
          protectedEndpoint = AppAuthEndpoint(
            smsService: smsService,
            rateLimitService: OtpRateLimitService(
              clientIpResolver: (_) => '192.0.2.77',
            ),
          );
        });

        Future<int> countAttempts(String purpose) => OtpAttempt.db.count(
          sessionBuilder.build(),
          where: (t) => t.purpose.equals(purpose),
        );

        test(
          'when a send is allowed then the attempt is recorded before '
          'Authentica is called',
          () async {
            int? attemptsSeenByProvider;

            smsService.onSend = () async {
              attemptsSeenByProvider = await countAttempts(
                OtpRateLimitService.sendPurpose,
              );
            };

            final result = await protectedEndpoint.sendOtp(
              sessionBuilder.build(),
              '0500000701',
            );

            expect(result, isTrue);
            expect(attemptsSeenByProvider, 1);
          },
        );

        test(
          'when a second send follows within 60 seconds then it is rate '
          'limited and no SMS is sent',
          () async {
            await protectedEndpoint.sendOtp(
              sessionBuilder.build(),
              '0500000702',
            );

            await expectLater(
              protectedEndpoint.sendOtp(sessionBuilder.build(), '0500000702'),
              throwsMeerException('OTP_RATE_LIMITED'),
            );

            expect(smsService.sendCalls, 1);
            expect(await countAttempts(OtpRateLimitService.sendPurpose), 1);
          },
        );

        test(
          'when the SMS provider fails then the attempt still counts against '
          'the limits',
          () async {
            smsService.sendResult = false;

            expect(
              await protectedEndpoint.sendOtp(
                sessionBuilder.build(),
                '0500000703',
              ),
              isFalse,
            );

            await expectLater(
              protectedEndpoint.sendOtp(sessionBuilder.build(), '0500000703'),
              throwsMeerException('OTP_RATE_LIMITED'),
            );

            expect(smsService.sendCalls, 1);
          },
        );

        test(
          'when the phone format is invalid then no attempt is recorded',
          () async {
            await expectLater(
              protectedEndpoint.sendOtp(sessionBuilder.build(), '12345'),
              throwsMeerException('INVALID_PHONE_FORMAT'),
            );

            expect(await countAttempts(OtpRateLimitService.sendPurpose), 0);
          },
        );

        test(
          'when verifyOtp and linkVerifiedPhone are mixed then they share '
          'one verification counter for the phone',
          () async {
            const phone = '0500000704';

            smsService.verifyResult = false;

            final linkSession = await authenticatedSessionWithProfile();

            // 5 محاولات مسموحة خلال 10 دقائق، موزعة على المسارين.
            for (var i = 0; i < 3; i++) {
              await expectLater(
                protectedEndpoint.verifyOtp(
                  sessionBuilder.build(),
                  phone,
                  '000000',
                ),
                throwsMeerException('INVALID_PHONE_OTP'),
              );
            }

            for (var i = 0; i < 2; i++) {
              await expectLater(
                protectedEndpoint.linkVerifiedPhone(
                  linkSession,
                  phone,
                  '000000',
                ),
                throwsMeerException('INVALID_PHONE_OTP'),
              );
            }

            expect(smsService.verifyCalls, 5);

            // المحاولة السادسة مرفوضة من أي مسار، حتى لو كان الرمز صحيحًا.
            smsService.verifyResult = true;

            await expectLater(
              protectedEndpoint.linkVerifiedPhone(linkSession, phone, '123456'),
              throwsMeerException('OTP_RATE_LIMITED'),
            );
            await expectLater(
              protectedEndpoint.verifyOtp(
                sessionBuilder.build(),
                phone,
                '123456',
              ),
              throwsMeerException('OTP_RATE_LIMITED'),
            );

            expect(smsService.verifyCalls, 5);
            expect(await countAttempts(OtpRateLimitService.verifyPurpose), 5);
          },
        );
      });
    },
  );

  group('Given auth errors sent to the client', () {
    final errors = {
      'OTP_RATE_LIMITED': AuthErrors.rateLimited(),
      'INVALID_PHONE_OTP': AuthErrors.invalidOtp(),
      'INVALID_PHONE_FORMAT': AuthErrors.invalidPhoneFormat(),
      'PHONE_ALREADY_IN_USE': AuthErrors.phoneAlreadyInUse(),
      'ACCOUNT_ALREADY_HAS_PHONE': AuthErrors.accountAlreadyHasPhone(),
    };

    for (final MapEntry(key: code, value: error) in errors.entries) {
      test(
        'when $code is serialized for the protocol then it keeps its type, '
        'code and message',
        () {
          final protocol = Protocol();

          expect(error, isA<SerializableException>());
          expect(error.code, code);

          // نفس الترميز الذي يستخدمه Serverpod في رد الخطأ (HTTP 400).
          final body = protocol.encodeWithTypeForProtocol(error);
          final json = jsonDecode(body) as Map<String, dynamic>;

          expect(json['className'], 'MeerException');
          expect(
            (json['data'] as Map<String, dynamic>).keys,
            unorderedEquals(['__className__', 'code', 'message']),
          );

          final decoded = protocol.decodeWithType(body);

          expect(
            decoded,
            isA<MeerException>()
                .having((e) => e.code, 'code', code)
                .having((e) => e.message, 'message', error.message),
          );
        },
      );
    }
  });

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

  /// يُستدعى لحظة وصول الطلب إلى مزود الرسائل.
  Future<void> Function()? onSend;

  @override
  Future<bool> sendOtp(Session session, String phone) async {
    sendCalls++;
    lastPhone = phone;

    await onSend?.call();

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
