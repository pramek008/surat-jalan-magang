import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:surat_jalan/services/location_service.dart';

class MapProviderServices with ChangeNotifier {
  late LatLng _gpsactual;
  LatLng _initialposition = const LatLng(-7.8093128, 110.3136509);
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  bool activegps = true;
  TextEditingController locationController = TextEditingController();

  LatLng get gpsPosition => _gpsactual;
  LatLng get initialPos => _initialposition;
  Set<Marker> get markers => _markers;
  GoogleMapController get mapController => _mapController;

  void setGpsPosition(LatLng position) {
    _gpsactual = position;
    notifyListeners();
  }

  void getMoveCamera() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _initialposition.latitude, _initialposition.longitude,
        localeIdentifier: "id_ID");

    String name = placemark[0].name!;
    String sublocal = placemark[0].subLocality!;
    String city = placemark[0].locality!;
    String subdistrict = placemark[0].subAdministrativeArea!;
    String province = placemark[0].administrativeArea!;
    String country = placemark[0].country!;

    locationController.text =
        "$name, $sublocal, $city, $subdistrict, $province, $country";
    notifyListeners();
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  void onCameraMove(CameraPosition position) async {
    // print(position.target);
    _initialposition = position.target;
    print("VIEWPoss: ${_initialposition.toString()}");
    notifyListeners();
  }

  void getCurrentLocation() async {
    LocationService locationService = LocationService();

    Position position = await locationService.determinePosition();
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    _initialposition = LatLng(position.latitude, position.longitude);
    print(
        "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
    locationController.text = placemark[0].subLocality!;
    _addMarker(_initialposition, placemark[0].name!);
    _mapController.moveCamera(CameraUpdate.newLatLng(_initialposition));
    print("initial position is : ${placemark[0].locality}");
    notifyListeners();
  }
}
