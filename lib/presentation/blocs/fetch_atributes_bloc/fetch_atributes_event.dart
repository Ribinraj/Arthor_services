part of 'fetch_atributes_bloc.dart';

@immutable
sealed class FetchAtributesEvent {}

final class FetchAtributesInitialEvent extends FetchAtributesEvent {
  final String verificationTypeId;

  FetchAtributesInitialEvent({required this.verificationTypeId});
}
