part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;
  final Placemark address;

  LocationLoaded({
    required this.position,
    required this.address,
  });

  List<Object?> get props => [position, address];
}

class LocationFromDb extends LocationState {
  final Placemark address;

  LocationFromDb({
    required this.address,
  });

  List<Object?> get props => [address];
}

class LocationError extends LocationState {
  final String message;

  LocationError({
    required this.message,
  });

  List<Object?> get props => [message];
}
