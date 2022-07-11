part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final InformationModel informationModel;

  ThemeLoaded({required this.informationModel});

  List<Object?> get props => [informationModel];
}

class ThemeCondition extends ThemeState {
  final bool isOnRange;

  ThemeCondition({required this.isOnRange});

  List<Object?> get props => [isOnRange];
}

class ThemeImage extends ThemeState {
  final String image;

  ThemeImage({required this.image});

  List<Object?> get props => [image];
}

class ThemeError extends ThemeState {
  final String message;

  ThemeError({required this.message});

  List<Object?> get props => [message];
}
