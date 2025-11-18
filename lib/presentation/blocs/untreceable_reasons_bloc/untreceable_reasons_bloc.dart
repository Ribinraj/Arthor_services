import 'dart:async';

import 'package:arthor/data/untreceablereason_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'untreceable_reasons_event.dart';
part 'untreceable_reasons_state.dart';

class UntreceableReasonsBloc
    extends Bloc<UntreceableReasonsEvent, UntreceableReasonsState> {
  final Apprepo repository;
  UntreceableReasonsBloc({required this.repository})
    : super(UntreceableReasonsInitial()) {
    on<UntreceableReasonsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UntreceableReasonsFetchingInitialEvent>(fetchreasons);
  }

  FutureOr<void> fetchreasons(
    UntreceableReasonsFetchingInitialEvent event,
    Emitter<UntreceableReasonsState> emit,
  ) async {
    emit(UntreceableReasonsLoadingState());
    try {
      final response = await repository.untreceableresons();
      if (!response.error && response.status == 200) {
        emit(UntreceableReasonsSuccessState(reasons: response.data!));
      } else {
        emit(UntreceableReasonsErrorState(message: response.message));
      }
    } catch (e) {
      emit(UntreceableReasonsErrorState(message: e.toString()));
    }
  }
}
