part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequestedEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginRequestedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
