import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:surat_jalan/bloc/postreport_bloc.dart';
import 'package:surat_jalan/services/map_provider_services.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:surat_jalan/ui/pages/gmap_fullview_page.dart';

class LaporanKegiatanAddPage extends StatefulWidget {
  final int userId;
  final int suratJalanId;
  const LaporanKegiatanAddPage(
      {Key? key, required this.userId, required this.suratJalanId})
      : super(key: key);

  @override
  State<LaporanKegiatanAddPage> createState() => _LaporanKegiatanAddPageState();
}

class _LaporanKegiatanAddPageState extends State<LaporanKegiatanAddPage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imagesList = [];
  final List<String> _lokasi = [];

  final TextEditingController notulenController = TextEditingController();
  final TextEditingController namaKegiatanController = TextEditingController();

  GoogleMapController? _mapController;
  static LatLng _latLng = const LatLng(-7.8093128, 110.3136509);
  static CameraPosition _initialCameraPosition = CameraPosition(
    target: _latLng,
    zoom: 14,
  );
  final Set<Marker> _markers = {};

  LatLng? _currentPosition;

  Future<void> fromGallery() async {
    final List<XFile>? selectedImage =
        await _picker.pickMultiImage(maxHeight: 1000, maxWidth: 1000);
    if (selectedImage != null) {
      _imagesList.addAll(selectedImage);
    }
    setState(() {});
    // print(_imagesList);
  }

  void fromCamera() async {
    final XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    if (selectedImage != null) {
      _imagesList.add(selectedImage);
    }
    setState(() {});
    // print(selectedImage!.readAsBytes());
    // print('list lengt ${_imagesList.length}');
  }

  void _awaitReturnValueFrom(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => MapProviderServices(),
          child: const GmapView(),
        ),
      ),
    );
    // print(result);
    if (result != null) {
      _currentPosition = result;
      _latLng = result;
      setState(() {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 18,
            ),
          ),
        );
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('myMarker'),
            onDrag: (LatLng position) {
              setState(() {
                position = _latLng;
              });
              // print("Drag Position: $position");
            },
            position: _currentPosition ??
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      });
      _lokasi.clear();
      while (_lokasi.length <= 1) {
        _lokasi.add(_currentPosition!.latitude.toString());
        _lokasi.add(_currentPosition!.longitude.toString());
      }
      // print("Position TO POST: ${_currentPosition.toString()}");
      // print("LOKASI TO POST: ${_lokasi.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;

    //*========================== UI ============================
    Widget heading() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Keluar Halaman ?',
                      style: txSemiBold.copyWith(
                        color: primaryColor.withOpacity(0.8),
                        fontSize: 22,
                      ),
                    ),
                    content: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Apakah anda yakin ingin keluar dari halaman ini ?',
                            style: txRegular.copyWith(
                              color: greyDeepColor,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nSemua data yang belum disimpan akan hilang',
                            style: txMedium.copyWith(
                              color: redStatusColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Tidak',
                          style: txMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Keluar',
                            style: txMedium.copyWith(color: primaryColor)),
                      )
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 25,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Laporan Kegiatan',
              style: txSemiBold.copyWith(
                color: whiteColor,
                fontSize: 20,
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    }

    Widget content() {
      Widget dateTime() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu',
              style: txMedium.copyWith(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat(
                    'EEEE, dd MMMM yyyy  kk:mm ',
                    "id_ID",
                  ).format(
                    DateTime.now(),
                  ),
                  style: txRegular.copyWith(
                    color: greyDeepColor,
                  ),
                ),
              ],
            ),
          ],
        );
      }

      Widget namaKegiatan() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kegiatan',
              style: txMedium.copyWith(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: namaKegiatanController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama kegiatan',
                hintStyle: txRegular.copyWith(
                  color: greyIconColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: greyIconColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        );
      }

      Widget tanggal() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Mulai',
                    style: txMedium.copyWith(
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat(
                      'EEEE, dd MMMM yyyy ',
                      "id_ID",
                    ).format(DateTime.now()),
                    style: txRegular.copyWith(
                      color: greyDeepColor,
                    ),
                  ),
                  Text(
                    DateFormat(
                      'kk:mm ',
                      "id_ID",
                    ).format(
                      DateTime.now(),
                    ),
                    style: txRegular.copyWith(
                      color: greyDeepColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Tanggal Selesai',
                    style: txMedium.copyWith(
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat(
                      'EEEE, dd MMMM yyyy',
                      "id_ID",
                    ).format(DateTime.now()),
                    style: txRegular.copyWith(
                      color: greyDeepColor,
                    ),
                  ),
                  Text(
                    DateFormat(
                      'kk:mm ',
                      "id_ID",
                    ).format(
                      DateTime.now(),
                    ),
                    style: txRegular.copyWith(
                      color: greyDeepColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }

      Widget fotoKegiatan() {
        bool isImage = _imagesList.isNotEmpty;
        int coutList = _imagesList.length;
        int manyRow = (coutList / 3).ceil();

        Widget buildSheet(context, state) => Material(
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 8,
                      width: 50,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: greySubHeaderColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        fromCamera();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: greyDeepColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'From Camera',
                            style: txMedium.copyWith(
                              fontSize: 18,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        fromGallery();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 40,
                            color: greyDeepColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'From Galery',
                            style: txMedium.copyWith(
                              fontSize: 18,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

        //*Buttom Sheet builder
        Future showSheet() {
          FocusManager.instance.primaryFocus!.unfocus();
          return showSlidingBottomSheet(
            context,
            builder: (context) => SlidingSheetDialog(
              snapSpec: const SnapSpec(
                snappings: [0.7, 0.7],
              ),
              builder: buildSheet,
              padding: const EdgeInsets.only(
                // top: 24,
                left: 20,
                right: 20,
                bottom: 28,
              ),
              elevation: 12,
              cornerRadius: 16,
              dismissOnBackdropTap: true,
            ),
          );
        }

        Widget imageData(File image, int index) {
          return Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 17,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _imagesList.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: greyDeepColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: whiteColor,
                        size: 25,
                      ),
                    ),
                  )),
            ],
          );
        }

        Widget addImage() {
          return InkWell(
            onTap: showSheet,
            child: DottedBorder(
              color: greyIconColor,
              radius: const Radius.circular(20),
              dashPattern: const [10, 10],
              borderType: BorderType.RRect,
              strokeWidth: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon_addPicture.png',
                        width: 30,
                        height: 30,
                        color: greyIconColor,
                      ),
                      Text(
                        'Tambah Foto',
                        style: txRegular.copyWith(
                          color: greyIconColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foto Kegiatan',
              style: txMedium.copyWith(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: isImage ? (manyRow * 125) : 10,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: _imagesList.length,
                itemBuilder: (context, index) =>
                    imageData(File(_imagesList[index].path), index),
              ),
            ),
            addImage(),
          ],
        );
      }

      Widget notulen() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notulen',
              style: txMedium.copyWith(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: notulenController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Masukkan nama kegiatan',
                hintStyle: txRegular.copyWith(
                  color: greyIconColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: greyIconColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        );
      }

      Widget lokasi() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lokasi Kegiatan',
                  style: txMedium.copyWith(
                    color: primaryColor,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus!.unfocus();
                    _awaitReturnValueFrom(context);
                  },
                  style: TextButton.styleFrom(
                    shadowColor: primaryColor.withOpacity(0.8),
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'Set Lokasi',
                    style: txMedium.copyWith(
                      color: whiteColor,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: greyDeepColor,
              ),
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                markers: _markers,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                onCameraMove: (CameraPosition position) {
                  _initialCameraPosition = position;
                },
              ),
            )
          ],
        );
      }

      Widget btnSubmit() {
        return BlocConsumer<PostreportBloc, PostreportState>(
          listener: (context, state) {
            if (state is PostreportSuccessState) {
              // print('SUCCESS state ${state.response.toString()}');
              if (state.response.status.toString() == "success") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.response.message.toString(),
                      style: txRegular.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    backgroundColor: greenStatusColor,
                  ),
                );
                Navigator.of(context).pop();
              }
            } else if (state is PostreportFailureState) {
              // print('FAILURE state ${state.response.toString()}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.response.message.toString(),
                    style: txRegular.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  backgroundColor: redStatusColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (_isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () {
                  if (namaKegiatanController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Nama Kegiatan tidak boleh kosong',
                          style: txRegular.copyWith(
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: redStatusColor,
                      ),
                    );
                  } else if (notulenController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Notulen tidak boleh kosong',
                          style: txRegular.copyWith(
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: redStatusColor,
                      ),
                    );
                  } else if (_lokasi.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Lokasi tidak boleh kosong',
                          style: txRegular.copyWith(
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: redStatusColor,
                      ),
                    );
                  } else if (_imagesList.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Foto tidak boleh kosong',
                          style: txRegular.copyWith(
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: redStatusColor,
                      ),
                    );
                  } else {
                    context.read<PostreportBloc>().add(PostreportRequestedEvent(
                        userId: widget.userId,
                        perintahJalanId: widget.suratJalanId,
                        namaKegiatan: namaKegiatanController.text,
                        images: _imagesList,
                        lokasi: _lokasi,
                        deskripsi: notulenController.text));
                    _isLoading = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Kegiatan Sedang ditambahkan, Mohon Tunggu',
                          style: txRegular.copyWith(
                            color: whiteColor,
                          ),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                },
                child: Text(
                  'Buat Laporan',
                  style: txSemiBold.copyWith(
                    color: whiteColor,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          },
        );
      }

      //! Master WIDGET untuk content laporan kegiatan
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
          bottom: 50,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        child: Wrap(
          runSpacing: 20,
          children: [
            dateTime(),
            namaKegiatan(),
            tanggal(),
            fotoKegiatan(),
            notulen(),
            lokasi(),
            btnSubmit(),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Keluar Halaman ?',
              style: txSemiBold.copyWith(
                color: primaryColor.withOpacity(0.8),
                fontSize: 22,
              ),
            ),
            content: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Apakah anda yakin ingin keluar dari halaman ini ?',
                    style: txRegular.copyWith(
                      color: greyDeepColor,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '\n\nSemua data yang belum disimpan akan hilang',
                    style: txMedium.copyWith(
                      color: redStatusColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tidak',
                  style: txMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                },
                child: Text('Keluar',
                    style: txMedium.copyWith(color: primaryColor)),
              )
            ],
          ),
        );
        return willLeave;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: Column(
                children: [
                  heading(),
                  content(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
