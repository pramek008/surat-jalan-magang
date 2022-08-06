import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:surat_jalan/shared/shared_theme.dart';

Future<Uint8List> generatePdf(String report) async {
  final pdf = pw.Document();
  final imageLogo =
      (await rootBundle.load('assets/logo_daerah.png')).buffer.asUint8List();

  pw.Widget header() {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.SizedBox(
              width: 65,
              height: 65,
              child: pw.Image(pw.MemoryImage(imageLogo)),
            ),
            pw.Spacer(),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  "Pemerintah Provinsi Maluku Utara".toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "Dinas Daerah Provinsi Maluku Utara",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.Text(
                  "Jl. Raya Km. 1,5, Maluku Utara",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
            pw.Spacer(),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Divider(
          color: PdfColor.fromHex('#000000'),
          thickness: 1,
        )
      ],
    );
  }

  pw.Widget body() {
    return pw.Column(
      children: [
        pw.Text(
          report,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.portrait,
      build: (context) {
        return pw.Column(
          children: [
            header(),
            body(),
          ],
        );
      },
    ),
  );
  return pdf.save();
}
