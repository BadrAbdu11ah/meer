import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/repository/auth_repository.dart';

part 'login_state.dart';
part 'login_event.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState.initial()) {
    // // 1. معالجة تسجيل الدخول عبر جوجل
    on<GoogleSignInRequested>((event, emit) async {
      if (state is _LoginLoading) return;
      if (state is _Authenticated) return;
      emit(const LoginState.loading());

      final result = await authRepository.signInWithGoogle();

      result.fold(
        (failure) => emit(LoginState.error(failure.message)),
        (userProfile) => emit(LoginState.authenticated(userProfile)),
      );
    });

    // // 2. معالجة إرسال رمز الـ OTP برقم الهاتف
    on<SendOtpRequested>((event, emit) async {
      if (state is _LoginLoading) return;
      emit(const LoginState.loading());

      final result = await authRepository.sendOtp(phone: event.phone);

      result.fold(
        (failure) => emit(LoginState.error(failure.message)),
        (success) =>
            emit(const LoginState.otpSent()), // // الانتقال لشاشة إدخال الكود
      );
    });
  }
}
