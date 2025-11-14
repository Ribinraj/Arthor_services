import 'dart:async';

import 'package:arthor/data/cases_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_newcases_event.dart';
part 'fetch_newcases_state.dart';

class FetchNewcasesBloc extends Bloc<FetchNewcasesEvent, FetchNewcasesState> {
  final Apprepo repository;
  FetchNewcasesBloc({required this.repository}) : super(FetchNewcasesInitial()) {
    on<FetchNewcasesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchNecasesInitialEvent>(fetchnewcases);
  }

  FutureOr<void> fetchnewcases(FetchNecasesInitialEvent event, Emitter<FetchNewcasesState> emit)async {
    emit(FetchNewCasesLoadingState());
    try {
      final response=await repository.fetchnewcases();
      if (response.status==200) {
        emit(FetchNewCasesSuccessState(newcases: response.data!));
      }
      else{
        emit(FetchNewCasesErroStatae(message: response.message));
      }
    } catch (e) {
      emit(FetchNewCasesErroStatae(message: e.toString()));
    }
  }
  
}
