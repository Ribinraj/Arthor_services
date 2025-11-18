import 'dart:async';

import 'package:arthor/data/atributes_model.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_atributes_event.dart';
part 'fetch_atributes_state.dart';

class FetchAtributesBloc
    extends Bloc<FetchAtributesEvent, FetchAtributesState> {
  final Apprepo repository;
  FetchAtributesBloc({required this.repository})
    : super(FetchAtributesInitial()) {
    on<FetchAtributesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchAtributesInitialEvent>(fetchAtributes);
  }

  FutureOr<void> fetchAtributes(
    FetchAtributesInitialEvent event,
    Emitter<FetchAtributesState> emit,
  ) async {
    emit(FetchAtributesLoadingState());
    try {
      final response = await repository.fetchatributes(
        verificationTypeId: event.verificationTypeId,
      );
      if (!response.error && response.status == 200) {
        emit(FetchAtributesSuccessState(atributes: response.data!));
      } else {
        emit(FetchAtributesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchAtributesErrorState(message: e.toString()));
    }
  }
}
