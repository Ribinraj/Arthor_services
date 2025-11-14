part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}
final class VerifyOtpButtonclickEvent extends VerifyOtpEvent {
 final String executiveId;
 final String executiveOtp;

  VerifyOtpButtonclickEvent({required this.executiveId, required this.executiveOtp});

  



}