part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpEvent {}

final class ResendOtpClickEvent extends ResendOtpEvent {
  final String loginId;
  final String loginType;

  ResendOtpClickEvent({required this.loginId, required this.loginType});
}
