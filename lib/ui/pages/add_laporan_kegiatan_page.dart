import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:surat_jalan/cubit/location_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';

class LaporanKegiatanAddPage extends StatefulWidget {
  const LaporanKegiatanAddPage({Key? key}) : super(key: key);

  @override
  State<LaporanKegiatanAddPage> createState() => _LaporanKegiatanAddPageState();
}

class _LaporanKegiatanAddPageState extends State<LaporanKegiatanAddPage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imagesList = [];

  Future<void> fromGallery() async {
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    if (selectedImage != null) {
      _imagesList.addAll(selectedImage);
    }
    setState(() {});
    // print(selectedImage!.length);
    // print(_imagesList);
  }

  void fromCamera() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      _imagesList.add(selectedImage);
    }
    setState(() {});
    // print(selectedImage!.path);
    // print('list lengt ${_imagesList.length}');
  }

  @override
  Widget build(BuildContext context) {
    //* Text field controller
    TextEditingController notulenController = TextEditingController();
    TextEditingController namaKegiatanController = TextEditingController();

    String? street;
    String? subLocality;
    String? locality;
    String? subAdministrativeArea;
    String? administrativeArea;
    String? country;

    String oneLineAdd =
        '${street ?? ''} ${subLocality ?? ''} ${locality ?? ''} ${subAdministrativeArea ?? ''} ${administrativeArea ?? ''} ${country ?? ''}';

    double latitude;
    double longitude;

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
                Navigator.pop(context);
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
            Column(
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
                  ).format(
                    DateTime.now(),
                  ),
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
            const SizedBox(
              width: 12,
            ),
            Column(
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
                  ).format(
                    DateTime.now(),
                  ),
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
                      imageData(File(_imagesList[index].path), index)),
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
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.toString(),
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
            if (state is LocationLoading) {
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
                        onPressed: () {
                          context.read<LocationCubit>().getCurrentLocation();
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (state is LocationLoaded) {
              //* menangkap data alamat menurut lokasi
              street = state.address.street.toString();
              subLocality = state.address.subLocality.toString();
              locality = state.address.locality.toString();
              subAdministrativeArea =
                  state.address.subAdministrativeArea.toString();
              administrativeArea = state.address.administrativeArea.toString();
              country = state.address.country.toString();

              oneLineAdd =
                  '$street, $subLocality, $locality, $subAdministrativeArea, $administrativeArea, $country';

              //* menangkap data lokasi (long dan lat)
              longitude = state.position.longitude;
              latitude = state.position.latitude;
              print(state.position);
              print(state.address.toString());
            }
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
                      onPressed: () {
                        context.read<LocationCubit>().getCurrentLocation();
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style: txMedium.copyWith(
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        oneLineAdd,
                        style: txRegular.copyWith(
                          fontSize: 16,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }

      Widget btnSubmit() {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {},
            child: Text(
              'Buat Laporan',
              style: txSemiBold.copyWith(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
          ),
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

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultMargin,
              // right: defaultMargin,
              // left: defaultMargin,
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
    );
  }
}
