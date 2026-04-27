import 'dart:async';

import 'package:arthor/domain/repositories/loginrepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final Loginrepo repository;
  ResendOtpBloc({required this.repository}) : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ResendOtpClickEvent>(resentotp);
  }
  FutureOr<void> resentotp(
    ResendOtpClickEvent event,
    Emitter<ResendOtpState> emit,
  ) async {
    emit(ResendOtpLoadingState());
    try {
      final response = await repository.resendotp(
        loginId: event.loginId,
        loginType: event.loginType,
      );
      if (!response.error && response.status == 200) {
        emit(ResendOtpSuccessState(message: response.message));
      } else {
        emit(ResendOtpErrorState(message: response.message));
      }
    } catch (e) {
      emit(ResendOtpErrorState(message: e.toString()));
    }
  }
}
