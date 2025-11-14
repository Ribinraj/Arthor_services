part of 'fetch_newcases_bloc.dart';

@immutable
sealed class FetchNewcasesState {}

final class FetchNewcasesInitial extends FetchNewcasesState {}
final class FetchNewCasesLoadingState extends FetchNewcasesState{}
final class FetchNewCasesSuccessState extends FetchNewcasesState{
  final List<CaseDataModel>newcases;

  FetchNewCasesSuccessState({required this.newcases});
}
final class FetchNewCasesErroStatae extends FetchNewcasesState{
  final String message;

  FetchNewCasesErroStatae({required this.message});
}