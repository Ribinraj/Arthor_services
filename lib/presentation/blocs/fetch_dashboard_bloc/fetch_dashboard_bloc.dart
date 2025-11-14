import 'dart:async';

import 'package:arthor/data/dashboard_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_dashboard_event.dart';
part 'fetch_dashboard_state.dart';

class FetchDashboardBloc extends Bloc<FetchDashboardEvent, FetchDashboardState> {
  final Apprepo repository;
  FetchDashboardBloc({required this.repository}) : super(FetchDashboardInitial()) {
    on<FetchDashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDashboardInitialFetchingEvent>(fetchdashboard);
  }

  FutureOr<void> fetchdashboard(FetchDashboardInitialFetchingEvent event, Emitter<FetchDashboardState> emit)async {
    emit(FetchDashboardLoadingState());
    try {
      final response=await repository.fetchdashboard();
      if (!response.error && response.status==200) {
        emit(FetchDashboardSuccessState(dashboard: response.data!));
      }else{
        emit(FetchDashboardErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchDashboardErrorState(message: e.toString()));
      
    }
  }
}
