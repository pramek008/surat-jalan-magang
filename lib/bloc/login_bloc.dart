import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await AuthService().login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess(response));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
