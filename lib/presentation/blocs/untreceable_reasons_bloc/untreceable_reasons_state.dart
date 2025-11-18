part of 'untreceable_reasons_bloc.dart';

@immutable
sealed class UntreceableReasonsState {}

final class UntreceableReasonsInitial extends UntreceableReasonsState {}

final class UntreceableReasonsLoadingState extends UntreceableReasonsState {}

final class UntreceableReasonsSuccessState extends UntreceableReasonsState {
  final List<UntreceableReasonModels> reasons;

  UntreceableReasonsSuccessState({required this.reasons});
}

final class UntreceableReasonsErrorState extends UntreceableReasonsState {
  final String message;

  UntreceableReasonsErrorState({required this.message});
}
