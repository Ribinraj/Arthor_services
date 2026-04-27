part of 'fetch_teamcases_bloc.dart';

@immutable
sealed class FetchTeamcasesEvent {}

final class FetchTeamcasesInitialEvent extends FetchTeamcasesEvent {}
