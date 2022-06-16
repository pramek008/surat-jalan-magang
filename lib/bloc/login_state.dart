part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final ResponseModel response;

  LoginSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class LoginFailureState extends LoginState {
  final ResponseModel response;

  LoginFailureState(this.response);

  @override
  List<Object?> get props => [response];
}
