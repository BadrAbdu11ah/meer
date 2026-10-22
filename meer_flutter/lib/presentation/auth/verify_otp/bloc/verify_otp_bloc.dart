import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/auth_repository.dart';

part 'verify_otp_state.dart';
part 'verify_otp_event.dart';
part 'verify_otp_bloc.freezed.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final AuthRepository authRepository;
  VerifyOtpBloc(this.authRepository) : super(const VerifyOtpState.initial()) {
    // // معالجة التحقق من الـ OTP وتسجيل الدخول
    on<VerifyOtpRequested>((event, emit) async {
      emit(const VerifyOtpState.loading());

      final result = await authRepository.verifyOtp(
        phone: event.phone,
        code: event.code,
      );

      result.fold(
        (failure) => emit(VerifyOtpState.error(failure.message)),
        (userProfile) => emit(
          VerifyOtpState.authenticated(userProfile),
        ), // // نجاح الدخول برقم الهاتف
      );
    });
  }
}
