part of 'form_submit_bloc.dart';

@immutable
sealed class FormSubmitEvent {}
class SubmitUntraceablePressed extends FormSubmitEvent {
  final UntreceableVerificationmodel  data;

  SubmitUntraceablePressed({required this.data});


}

class SubmitTraceablePressed extends FormSubmitEvent {
  final TreceableVerificationmodel data;

  SubmitTraceablePressed({required this.data});

}