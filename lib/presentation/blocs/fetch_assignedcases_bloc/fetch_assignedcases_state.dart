part of 'fetch_assignedcases_bloc.dart';

@immutable
sealed class FetchAssignedcasesState {}

final class FetchAssignedcasesInitial extends FetchAssignedcasesState {}
final class FetchAssignedcasesLoadingState extends FetchAssignedcasesState{}
final class FetchAssignedcasesSuccesstate extends FetchAssignedcasesState{
  final List<CaseDataModel>assignedcases;

  FetchAssignedcasesSuccesstate({required this.assignedcases});
}
final class FetchAssignedcasesErrorState extends FetchAssignedcasesState{
  final String message;

  FetchAssignedcasesErrorState({required this.message});
}