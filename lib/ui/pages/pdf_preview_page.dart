import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:surat_jalan/cubit/location_cubit.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/pdf_service.dart';

import '../../cubit/report_cubit.dart';

class PdfPreviewPage extends StatelessWidget {
  final LetterModel letter;
  final UserModel user;
  const PdfPreviewPage({
    Key? key,
    required this.letter,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportLoaded) {
            List<ReportModel> report = state.reports;
            List<ReportModel> reportByLetter = report
                .where((element) => element.userId.id == user.id)
                .where((element) => element.perintahJalanId.id == letter.id)
                .toList();
            // print(reportByLetter.length);
            // List<Placemark> address = [];
            // for (var i = 0; i < reportByLetter.length; i++) {
            //   BlocProvider.of<LocationCubit>(context).getLocationFromDb(
            //       double.parse(reportByLetter[i].lokasi[0]),
            //       double.parse(reportByLetter[i].lokasi[1]));
            // }
            return PdfPreview(
              build: (context) =>
                  PDFService().generatePdf(letter, user, reportByLetter),
              initialPageFormat: PdfPageFormat.a4,
              pdfFileName: 'Laporan_SPPD_${letter.userId.name}.pdf',
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
