import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogoutEvent>((event, emit) {
      AuthService().logout();
      // AuthService().deleteUser();
      emit(AuthUnauthenticatedState());
    });

    on<AuthLoadUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await AuthService().loadUser();
        emit(AuthAuthenticatedState(user));
      } catch (e) {
        emit(AuthUnauthenticatedState());
      }
    });
  }
}
