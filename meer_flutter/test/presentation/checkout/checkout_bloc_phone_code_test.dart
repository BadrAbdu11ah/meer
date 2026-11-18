import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/core/services/location_service.dart';
import 'package:meer_flutter/presentation/checkout/bloc/checkout_bloc.dart';
import 'package:meer_flutter/repository/auth_repository.dart';
import 'package:meer_flutter/repository/order_repository.dart';
import 'package:meer_flutter/repository/seller_repository.dart';

class _FakeOrderRepository extends Fake implements OrderRepository {}

class _FakeSellerRepository extends Fake implements SellerRepository {}

class _FakeLocationService extends Fake implements LocationService {}

class _FakeAuthRepository extends Fake implements AuthRepository {
  Either<Failure, bool> sendResult = const Right(true);
  Either<Failure, MeerUserProfile>? linkResult;

  int sendCalls = 0;
  final sentPhones = <String>[];

  @override
  Future<Either<Failure, bool>> sendOtp({required String phone}) async {
    sendCalls++;
    sentPhones.add(phone);

    return sendResult;
  }

  @override
  Future<Either<Failure, MeerUserProfile>> linkVerifiedPhone({
    required String phone,
    required String code,
  }) async {
    return linkResult!;
  }
}

void main() {
  const phone = '0501234567';

  late _FakeAuthRepository authRepository;
  late DateTime now;
  late CheckoutBloc bloc;

  CheckoutReady ready() => bloc.state as CheckoutReady;

  /// يرسل الحدث وينتظر حتى ينتهي الـ BLoC من معالجته.
  Future<List<CheckoutState>> dispatch(CheckoutEvent event) async {
    final states = <CheckoutState>[];
    final subscription = bloc.stream.listen(states.add);

    bloc.add(event);
    await pumpEventQueue();
    await subscription.cancel();

    return states;
  }

  setUp(() {
    authRepository = _FakeAuthRepository();
    now = DateTime.utc(2026, 1, 1, 12);

    bloc = CheckoutBloc(
      _FakeOrderRepository(),
      _FakeSellerRepository(),
      _FakeLocationService(),
      authRepository,
      now: () => now,
    );

    // ignore: invalid_use_of_visible_for_testing_member
    bloc.emit(const CheckoutState.ready());
  });

  tearDown(() => bloc.close());

  test('when no code was requested then there is no send time', () {
    expect(ready().codeSentAt, isNull);
    expect(ready().isPhoneCodeSent, isFalse);
  });

  test(
    'when the first send succeeds then the send time is recorded',
    () async {
      final states = await dispatch(
        const CheckoutEvent.phoneCodeRequested(phone: ' $phone '),
      );

      expect(authRepository.sentPhones, [phone]);

      // أثناء الإرسال لا يوجد وقت إرسال بعد.
      final sending = states.first as CheckoutReady;
      expect(sending.isSendingPhoneCode, isTrue);
      expect(sending.codeSentAt, isNull);

      expect(ready().isSendingPhoneCode, isFalse);
      expect(ready().isPhoneCodeSent, isTrue);
      expect(ready().codeSentAt, now);
      expect(ready().codeSentAt!.isUtc, isTrue);
      expect(ready().errorMessage, isNull);
    },
  );

  test(
    'when a second send succeeds then the send time changes',
    () async {
      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));
      final firstSentAt = ready().codeSentAt;

      now = now.add(const Duration(seconds: 61));
      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));

      expect(authRepository.sendCalls, 2);
      expect(ready().isPhoneCodeSent, isTrue);
      expect(ready().codeSentAt, now);
      expect(ready().codeSentAt, isNot(firstSentAt));
    },
  );

  test(
    'when the first send fails then no send time is recorded',
    () async {
      authRepository.sendResult = const Left(
        AuthFailure(
          'محاولات كثيرة. يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.',
        ),
      );

      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));

      expect(ready().isSendingPhoneCode, isFalse);
      expect(ready().isPhoneCodeSent, isFalse);
      expect(ready().codeSentAt, isNull);
      expect(
        ready().errorMessage,
        'محاولات كثيرة. يرجى الانتظار قليلًا ثم المحاولة مرة أخرى.',
      );
    },
  );

  test(
    'when a resend fails then the previous send time is kept',
    () async {
      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));
      final firstSentAt = ready().codeSentAt;

      now = now.add(const Duration(seconds: 61));
      authRepository.sendResult = const Left(ServerFailure('تعذر الإرسال'));

      final states = await dispatch(
        const CheckoutEvent.phoneCodeRequested(phone: phone),
      );

      expect(
        states.whereType<CheckoutReady>().map((state) => state.codeSentAt),
        everyElement(firstSentAt),
      );
      expect(ready().codeSentAt, firstSentAt);
      expect(ready().errorMessage, 'تعذر الإرسال');
    },
  );

  test(
    'when a send is already in progress then a second request is ignored',
    () async {
      final gate = Completer<void>();
      final slowRepository = _SlowAuthRepository(gate.future);

      final slowBloc = CheckoutBloc(
        _FakeOrderRepository(),
        _FakeSellerRepository(),
        _FakeLocationService(),
        slowRepository,
        now: () => now,
      );
      addTearDown(slowBloc.close);

      // ignore: invalid_use_of_visible_for_testing_member
      slowBloc.emit(const CheckoutState.ready());

      slowBloc.add(const CheckoutEvent.phoneCodeRequested(phone: phone));
      await pumpEventQueue();
      slowBloc.add(const CheckoutEvent.phoneCodeRequested(phone: phone));
      await pumpEventQueue();

      gate.complete();
      await pumpEventQueue();

      expect(slowRepository.sendCalls, 1);
      expect((slowBloc.state as CheckoutReady).codeSentAt, now);
    },
  );

  test(
    'when the phone is verified then the send time is cleared',
    () async {
      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));
      expect(ready().codeSentAt, isNotNull);

      authRepository.linkResult = Right(
        MeerUserProfile(
          authUserId: UuidValue.fromString(
            '00000000-0000-4000-8000-000000000001',
          ),
          fullName: 'Test',
          phone: '966501234567',
          role: 'customer',
          createdAt: DateTime.utc(2026),
        ),
      );

      await dispatch(
        const CheckoutEvent.phoneVerificationSubmitted(
          phone: phone,
          code: '123456',
        ),
      );

      expect(ready().isPhoneVerified, isTrue);
      expect(ready().isPhoneCodeSent, isFalse);
      expect(ready().codeSentAt, isNull);
    },
  );

  test(
    'when verification fails then the send time is kept',
    () async {
      await dispatch(const CheckoutEvent.phoneCodeRequested(phone: phone));
      final sentAt = ready().codeSentAt;

      authRepository.linkResult = const Left(
        AuthFailure('رمز التحقق غير صحيح أو انتهت صلاحيته.'),
      );

      await dispatch(
        const CheckoutEvent.phoneVerificationSubmitted(
          phone: phone,
          code: '000000',
        ),
      );

      expect(ready().isPhoneVerified, isFalse);
      expect(ready().isPhoneCodeSent, isTrue);
      expect(ready().codeSentAt, sentAt);
      expect(ready().errorMessage, 'رمز التحقق غير صحيح أو انتهت صلاحيته.');
    },
  );
}

class _SlowAuthRepository extends Fake implements AuthRepository {
  _SlowAuthRepository(this._gate);

  final Future<void> _gate;
  int sendCalls = 0;

  @override
  Future<Either<Failure, bool>> sendOtp({required String phone}) async {
    sendCalls++;
    await _gate;

    return const Right(true);
  }
}
