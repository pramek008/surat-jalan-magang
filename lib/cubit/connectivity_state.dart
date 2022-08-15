part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivitySatusState extends ConnectivityState {
  final String isConnected;
  ConnectivitySatusState({
    required this.isConnected,
  });
  List<Object> get props => [isConnected];
}

class ConnectivityErrorState extends ConnectivityState {}
