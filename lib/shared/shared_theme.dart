import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surat_jalan/models/information_model.dart';
import 'package:surat_jalan/services/secure_storage_service.dart';

//* Function to listen if date is range or not
bool isRange(DateTime start, DateTime end) {
  if (start.isAfter(end)) {
    return false;
  } else {
    return true;
  }
}

//* Get color from local storage or api every time the app is started
Future<Color> getColor() async {
  final informationValue = await SecureStorageService.storage
      .read(key: SecureStorageService.informationKey);

  InformationModel information =
      InformationModel.fromJson(json.decode(informationValue!));

  if (information.startedAt != null && information.expiredAt != null) {
    if (isRange(information.startedAt!, information.expiredAt!)) {
      String colorData = information.mainColor.toString().substring(1);
      String colorFlutter = '0xff' + colorData;
      Color color = Color(int.parse(colorFlutter));
      return color;
    } else {
      return const Color(0xff006EE9);
    }
  } else {
    return const Color(0xff006EE9);
  }
}

double defaultMargin = 20;

// Color primaryColor = getColor();
Color primaryColor = const Color(0xff006EE9);
// Color primaryLocalColor = Color(0xff006EE9);
// Color primaryColor = const Color(0xffF9F9C5);
Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff000000);
Color greyDeepColor = const Color(0xff4A4646);
Color greyThinColor = const Color(0xffF2F2F2);
Color greyIconColor = const Color(0xffA1A1A1);
Color greySubHeaderColor = const Color(0xff474747);

//*Status color
Color greenStatusColor = const Color(0xff60EA86);
Color redStatusColor = const Color(0xffEA6060);

Color backgrounColor = const Color(0xffFAFAFA);

TextStyle txBold =
    GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700);
TextStyle txSemiBold =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle txMedium =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500);
TextStyle txRegular =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400);
