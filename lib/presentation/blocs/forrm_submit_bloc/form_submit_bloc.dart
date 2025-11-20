import 'dart:async';

import 'package:arthor/data/treceable_verificationmodel.dart';
import 'package:arthor/data/untreceable_verificationmodel.dart';
import 'package:arthor/domain/repositories/apprepo.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'form_submit_event.dart';
part 'form_submit_state.dart';

class FormSubmitBloc extends Bloc<FormSubmitEvent, FormSubmitState> {
  final Apprepo repository;
  FormSubmitBloc({required this.repository}) : super(FormSubmitInitial()) {
    on<FormSubmitEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SubmitUntraceablePressed>(untreceablesubmit);
    on<SubmitTraceablePressed>(treceablesubmit);
  }

  FutureOr<void> untreceablesubmit(SubmitUntraceablePressed event, Emitter<FormSubmitState> emit)async {
    emit(FormSubmitLoadingState());
    try {
      final response= await repository.untreceableVerification(data: event.data);
    if (!response.error && response.status==200) {
      emit(FormSubmitSuccessState(message: response.message));
    }else{
      emit(FormSubmitErrorState(message: response.message));
    }
    } catch (e) {
         emit(FormSubmitErrorState(message:e.toString()));
    }
  }

  FutureOr<void> treceablesubmit(SubmitTraceablePressed event, Emitter<FormSubmitState> emit)async {
    emit(FormSubmitLoadingState());
    try {
            final response= await repository.treceableVerification(data: event.data);
    if (!response.error && response.status==200) {
      emit(FormSubmitSuccessState(message: response.message));
    }else{
      emit(FormSubmitErrorState(message: response.message));
    }
    } catch (e) {
      emit(FormSubmitErrorState(message:e.toString()));
    }
  }
}
