import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  Connectivity connectivity = Connectivity();
  ConnectivityCubit() : super(ConnectivityInitial()) {
    connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emit(ConnectivitySatusState(isConnected: 'connected'));
      } else {
        emit(ConnectivitySatusState(isConnected: 'disconnected'));
      }
    });
  }
}
