part of 'case_accept_decline_bloc.dart';
// case_accept_decline_state.dart
@immutable
sealed class CaseAcceptDeclineState {}

final class CaseAcceptDeclineInitial extends CaseAcceptDeclineState {}

// now includes caseId
final class CaseAcceptdeclineLoadingState extends CaseAcceptDeclineState {
  final String caseId;
  final bool isAccepting;

  CaseAcceptdeclineLoadingState({
    required this.caseId,
    required this.isAccepting,
  });
}

final class CaseAcceptdeclineSucessState extends CaseAcceptDeclineState {
  final String caseId;
  final String message;

  CaseAcceptdeclineSucessState({
    required this.caseId,
    required this.message,
  });
}

final class CaseAcceptancedeclineErrorState extends CaseAcceptDeclineState {
  final String caseId;
  final String message;

  CaseAcceptancedeclineErrorState({
    required this.caseId,
    required this.message,
  });
}

// @immutable
// sealed class CaseAcceptDeclineState {}

// final class CaseAcceptDeclineInitial extends CaseAcceptDeclineState {}
// final class CaseAcceptdeclineLoadingState extends CaseAcceptDeclineState{
//   final bool isAccepting;

//   CaseAcceptdeclineLoadingState({required this.isAccepting});
// }
// final class CaseAcceptdeclineSucessState extends CaseAcceptDeclineState{
//   final String message;

//   CaseAcceptdeclineSucessState({required this.message});
// }
// final class CaseAcceptancedeclineErrorState extends CaseAcceptDeclineState{
//   final String message;

//   CaseAcceptancedeclineErrorState({required this.message});
// }