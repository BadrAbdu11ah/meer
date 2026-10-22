part of 'verify_otp_bloc.dart';

@freezed
abstract class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.verifyOtpRequested({
    required String phone,
    required String code,
  }) = VerifyOtpRequested;
}
