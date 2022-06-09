part of 'letter_cubit.dart';

@immutable
abstract class LetterState {}

class LetterInitial extends LetterState {}

class LetterLoading extends LetterState {}

class LetterLoaded extends LetterState {
  final List<LetterModel> letters;

  LetterLoaded({
    required this.letters,
  });

  List<Object> get props => [letters];
}

class LetterError extends LetterState {
  final String message;

  LetterError({
    required this.message,
  });

  List<Object> get props => [message];
}
