part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoadUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticatedEvent extends AuthEvent {
  final UserModel user;

  const AuthAuthenticatedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
