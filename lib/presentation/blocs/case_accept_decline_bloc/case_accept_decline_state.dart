part of 'case_accept_decline_bloc.dart';

@immutable
sealed class CaseAcceptDeclineState {}

final class CaseAcceptDeclineInitial extends CaseAcceptDeclineState {}
final class CaseAcceptdeclineLoadingState extends CaseAcceptDeclineState{
  final bool isAccepting;

  CaseAcceptdeclineLoadingState({required this.isAccepting});
}
final class CaseAcceptdeclineSucessState extends CaseAcceptDeclineState{
  final String message;

  CaseAcceptdeclineSucessState({required this.message});
}
final class CaseAcceptancedeclineErrorState extends CaseAcceptDeclineState{
  final String message;

  CaseAcceptancedeclineErrorState({required this.message});
}