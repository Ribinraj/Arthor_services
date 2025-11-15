part of 'case_accept_decline_bloc.dart';

@immutable
sealed class CaseAcceptDeclineEvent {}
final class CaseAcceptButtonClickEvent extends CaseAcceptDeclineEvent{
  final String caseId;

  CaseAcceptButtonClickEvent({required this.caseId});
}
final class CaseDeclineButtonClickEvent extends CaseAcceptDeclineEvent{
  final String caseId;

  CaseDeclineButtonClickEvent({required this.caseId});
}