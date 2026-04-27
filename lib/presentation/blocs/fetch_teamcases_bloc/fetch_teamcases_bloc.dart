import 'dart:async';

import 'package:arthor/data/teamcases_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_teamcases_event.dart';
part 'fetch_teamcases_state.dart';

class FetchTeamcasesBloc extends Bloc<FetchTeamcasesEvent, FetchTeamcasesState> {
  final Apprepo repository;

  FetchTeamcasesBloc({required this.repository})
    : super(FetchTeamcasesInitial()) {
    on<FetchTeamcasesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTeamcasesInitialEvent>(_fetchTeamCases);
  }

  FutureOr<void> _fetchTeamCases(
    FetchTeamcasesInitialEvent event,
    Emitter<FetchTeamcasesState> emit,
  ) async {
    emit(FetchTeamcasesLoadingState());
    try {
      final response = await repository.fetchTeamCases();
      if (!response.error && response.status == 200) {
        emit(FetchTeamcasesSuccessState(teamCases: response.data!));
      } else {
        emit(FetchTeamcasesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchTeamcasesErrorState(message: e.toString()));
    }
  }
}
