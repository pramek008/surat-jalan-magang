import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:surat_jalan/cubit/location_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';

import '../../services/map_provider_services.dart';

class GmapView extends StatefulWidget {
  const GmapView({Key? key}) : super(key: key);

  @override
  State<GmapView> createState() => _GmapViewState();
}

class _GmapViewState extends State<GmapView> {
  late LatLng _currentPosition;

  @override
  Widget build(BuildContext context) {
    void _sendDataBack(BuildContext context) {
      Navigator.pop(context, _currentPosition);
    }

    final provmaps = Provider.of<MapProviderServices>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  markers: provmaps.markers,
                  onCameraMove: provmaps.onCameraMove,
                  initialCameraPosition:
                      CameraPosition(target: provmaps.initialPos, zoom: 18.0),
                  onMapCreated: provmaps.onCreated,
                  onCameraIdle: () async {
                    provmaps.getMoveCamera();
                    _currentPosition = provmaps.initialPos;
                    // print("CurrentPosition: ${_currentPosition.toString()}");
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 20,
              child: BlocListener<LocationCubit, LocationState>(
                listener: (context, state) {
                  if (state is LocationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<LocationCubit>().getCurrentLocation();
                    provmaps.getCurrentLocation();
                  },
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(
                    Icons.gps_fixed,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 135,
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lokasi Anda",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        provmaps.locationController.text,
                        style: txRegular.copyWith(
                          color: blackColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      // TextField(
                      //   maxLines: 3,
                      //   controller: provmaps.locationController,
                      //   decoration: InputDecoration(
                      //       contentPadding: EdgeInsetsGeometry.lerp(
                      //           const EdgeInsets.symmetric(horizontal: 15),
                      //           const EdgeInsets.symmetric(vertical: 15),
                      //           0.5),
                      //       border: OutlineInputBorder(
                      //           borderSide:
                      //               const BorderSide(color: Colors.white38),
                      //           borderRadius: BorderRadius.circular(10))),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: TextButton(
                onPressed: () {
                  _sendDataBack(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Pilih Lokasi",
                    style: txMedium.copyWith(color: whiteColor),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.location_on,
                size: 50,
                color: Colors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
