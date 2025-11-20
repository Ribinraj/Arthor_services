part of 'form_submit_bloc.dart';

@immutable
sealed class FormSubmitState {}

final class FormSubmitInitial extends FormSubmitState {}
final class FormSubmitLoadingState extends FormSubmitState{}
final class FormSubmitSuccessState extends FormSubmitState{
  final String message;

  FormSubmitSuccessState({required this.message});
}
final class FormSubmitErrorState extends FormSubmitState{
  final String message;

  FormSubmitErrorState({required this.message});
}