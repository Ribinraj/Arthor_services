import 'dart:async';

import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'case_accept_decline_event.dart';
part 'case_accept_decline_state.dart';

class CaseAcceptDeclineBloc extends Bloc<CaseAcceptDeclineEvent, CaseAcceptDeclineState> {
  final Apprepo repository;
  CaseAcceptDeclineBloc({required this.repository}) : super(CaseAcceptDeclineInitial()) {
    on<CaseAcceptDeclineEvent>((event, emit) {
      // TODO: implement event handler
    });
     on<CaseAcceptButtonClickEvent>(_onAcceptCase);
     on<CaseDeclineButtonClickEvent>(_onDeclineCase);
  }
  // case_accept_decline_bloc.dart (only the changed methods shown)
FutureOr<void> _onAcceptCase(
  CaseAcceptButtonClickEvent event,
  Emitter<CaseAcceptDeclineState> emit,
) async {
  emit(CaseAcceptdeclineLoadingState(caseId: event.caseId, isAccepting: true));
  try {
    final response = await repository.acceptrequest(caseId: event.caseId);
    if (!response.error && response.status == 200) {
      emit(CaseAcceptdeclineSucessState(caseId: event.caseId, message: response.message));
    } else {
      emit(CaseAcceptancedeclineErrorState(caseId: event.caseId, message: response.message));
    }
  } catch (e) {
    emit(CaseAcceptancedeclineErrorState(caseId: event.caseId, message: e.toString()));
  }
}

FutureOr<void> _onDeclineCase(
  CaseDeclineButtonClickEvent event,
  Emitter<CaseAcceptDeclineState> emit,
) async {
  emit(CaseAcceptdeclineLoadingState(caseId: event.caseId, isAccepting: false));
  try {
    final response = await repository.declinerequest(caseId: event.caseId);
    if (!response.error && response.status == 200) {
      emit(CaseAcceptdeclineSucessState(caseId: event.caseId, message: response.message));
    } else {
      emit(CaseAcceptancedeclineErrorState(caseId: event.caseId, message: response.message));
    }
  } catch (e) {
    emit(CaseAcceptancedeclineErrorState(caseId: event.caseId, message: e.toString()));
  }
}


  // FutureOr<void> _onAcceptCase(CaseAcceptButtonClickEvent event, Emitter<CaseAcceptDeclineState> emit) async{
  //   emit(CaseAcceptdeclineLoadingState(isAccepting: true));
  //   try {
  //     final response=await repository.acceptrequest(caseId: event.caseId);
  //     if (!response.error && response.status==200) {
  //       emit(CaseAcceptdeclineSucessState(message: response.message));
  //     }
  //     else{
  //       emit(CaseAcceptancedeclineErrorState(message: response.message));
  //     }
  //   } catch (e) {
  //     emit(CaseAcceptancedeclineErrorState(message: e.toString()));
  //   }
  // }

  // FutureOr<void> _onDeclineCase(CaseDeclineButtonClickEvent event, Emitter<CaseAcceptDeclineState> emit) async{
  //       emit(CaseAcceptdeclineLoadingState(isAccepting: false));
  //   try {
  //     final response=await repository.declinerequest(caseId: event.caseId);
  //     if (!response.error && response.status==200) {
  //       emit(CaseAcceptdeclineSucessState(message: response.message));
  //     }
  //     else{
  //       emit(CaseAcceptancedeclineErrorState(message: response.message));
  //     }
  //   } catch (e) {
  //     emit(CaseAcceptancedeclineErrorState(message: e.toString()));
  //   }
  // }
}
