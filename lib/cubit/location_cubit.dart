import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:surat_jalan/services/location_services.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  //*Get Current Location
  void getCurrentLocation() async {
    try {
      emit(LocationLoading());
      Position position = await LocationService().determinePosition();
      Placemark address = await LocationService().getAddress(position);
      emit(LocationLoaded(position: position, address: address));
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }
}
