part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticatedState extends AuthState {
  final UserModel user;

  AuthAuthenticatedState(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}
