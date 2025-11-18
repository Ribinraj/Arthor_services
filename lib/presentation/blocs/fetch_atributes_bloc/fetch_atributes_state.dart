part of 'fetch_atributes_bloc.dart';

@immutable
sealed class FetchAtributesState {}

final class FetchAtributesInitial extends FetchAtributesState {}

final class FetchAtributesLoadingState extends FetchAtributesState {}

final class FetchAtributesSuccessState extends FetchAtributesState {
  final List<AtributesModel> atributes;

  FetchAtributesSuccessState({required this.atributes});
}

final class FetchAtributesErrorState extends FetchAtributesState {
  final String message;

  FetchAtributesErrorState({required this.message});
}
