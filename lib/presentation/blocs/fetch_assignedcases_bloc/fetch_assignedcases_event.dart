part of 'fetch_assignedcases_bloc.dart';

@immutable
sealed class FetchAssignedcasesEvent {}
final class FetchAssignedcasesInitialFetchingEvent extends FetchAssignedcasesEvent{}