part of 'fetch_newcases_bloc.dart';

@immutable
sealed class FetchNewcasesEvent {}
final class FetchNecasesInitialEvent extends FetchNewcasesEvent{}