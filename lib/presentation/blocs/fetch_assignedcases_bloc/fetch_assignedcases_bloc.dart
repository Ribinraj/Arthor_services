import 'dart:async';

import 'package:arthor/data/cases_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_assignedcases_event.dart';
part 'fetch_assignedcases_state.dart';

class FetchAssignedcasesBloc extends Bloc<FetchAssignedcasesEvent, FetchAssignedcasesState> {
  final Apprepo repository;
  FetchAssignedcasesBloc({required this.repository}) : super(FetchAssignedcasesInitial()) {
    on<FetchAssignedcasesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchAssignedcasesInitialFetchingEvent>(fetchassignedcases);
  }

  FutureOr<void> fetchassignedcases(FetchAssignedcasesInitialFetchingEvent event, Emitter<FetchAssignedcasesState> emit) async{
    emit(FetchAssignedcasesLoadingState());
    try {
      final response=await repository.fetchasignnedcases();
      if (!response.error && response.status==200) {
        emit(FetchAssignedcasesSuccesstate(assignedcases: response.data!));
      }
      else{
        emit(FetchAssignedcasesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchAssignedcasesErrorState(message: e.toString()));
    }
  }
}
