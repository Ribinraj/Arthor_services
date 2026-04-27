part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

final class VerifyOtpButtonclickEvent extends VerifyOtpEvent {
  final String loginId;
  final String loginType;
  final String executiveOtp;

  VerifyOtpButtonclickEvent({
    required this.loginId,
    required this.loginType,
    required this.executiveOtp,
  });
}
