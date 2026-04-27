part of 'fetch_teamcases_bloc.dart';

@immutable
sealed class FetchTeamcasesState {}

final class FetchTeamcasesInitial extends FetchTeamcasesState {}

final class FetchTeamcasesLoadingState extends FetchTeamcasesState {}

final class FetchTeamcasesSuccessState extends FetchTeamcasesState {
  final List<TeamCaseModel> teamCases;

  FetchTeamcasesSuccessState({required this.teamCases});
}

final class FetchTeamcasesErrorState extends FetchTeamcasesState {
  final String message;

  FetchTeamcasesErrorState({required this.message});
}
