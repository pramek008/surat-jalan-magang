part of 'letter_bloc.dart';

@immutable
abstract class LetterState extends Equatable {}

class LetterInitial extends LetterState {
  @override
  List<Object?> get props => [];
}

class LetterLoadingState extends LetterState {
  @override
  List<Object?> get props => [];
}

class LetterSuccessState extends LetterState {
  final ResponseModel response;

  LetterSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class LetterFailureState extends LetterState {
  final ResponseModel response;

  LetterFailureState(this.response);

  @override
  List<Object?> get props => [response];
}
