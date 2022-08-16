import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/location_service.dart';
import 'package:surat_jalan/shared/shared_value.dart';

class PDFService {
  Future<Uint8List> generatePdf(
    LetterModel letterModel,
    UserModel userModel,
    List<ReportModel> reportModel,
  ) async {
    final pdf = pw.Document();
    final imageLogo =
        (await rootBundle.load('assets/logo_daerah.png')).buffer.asUint8List();

    //? build data image to byte
    List imageGroup = [];
    for (var i = 0; i < reportModel.length; i++) {
      List imageDataByGroup = [];
      for (var j = 0; j < reportModel[i].foto.length; j++) {
        final response = await http
            .get(Uri.parse('$baseImageURL/${reportModel[i].foto[j]}'));
        imageDataByGroup.add(response.bodyBytes);
      }
      imageGroup.add(imageDataByGroup);
      print('imageDataByGroup: ${imageDataByGroup.length}');
    }
    print('imageGroup: ${imageGroup.length}');

    //? build data address to string
    List address = [];
    for (var i = 0; i < reportModel.length; i++) {
      double lat = double.parse(reportModel[i].lokasi[0].toString());
      double long = double.parse(reportModel[i].lokasi[1].toString());
      final response = await LocationService().getAddressFromDb(lat, long);
      Placemark place = response;
      String addressString =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';

      address.add(addressString);
    }

    int daysLengt(DateTime from, DateTime to) {
      from = DateTime(letterModel.tglAwal.year, letterModel.tglAwal.month,
          letterModel.tglAwal.day);
      to = DateTime(letterModel.tglAkhir.year, letterModel.tglAkhir.month,
          letterModel.tglAkhir.day);
      return to.difference(from).inDays + 1;
    }

    //* Template data report
    pw.Widget itemData(String title, String value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 12),
              child: pw.Text(
                ":",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Text(
                value,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                  lineSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      );
    }

    pw.Widget itemListData(String title, List<String> member) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 12),
              child: pw.Text(
                ":",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Text(
                member.join("\n"),
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                  lineSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      );
    }

    pw.Widget itemListBullet(String title, List<String> value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Flexible(
              flex: 2,
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 12),
              child: pw.Text(
                ":",
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ),
            pw.Flexible(
              flex: 4,
              child: pw.Container(
                child: pw.Row(
                  children: [
                    pw.Bullet(),
                    pw.Text(value[0]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    //* End template data report

    //** SPPD Page ===========================================================
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
          pw.SizedBox(height: 4),
          pw.Divider(
            color: PdfColor.fromHex('#000000'),
            thickness: 3,
            borderStyle: pw.BorderStyle.solid,
          ),
          // pw.Divider(
          //   color: PdfColor.fromHex('#000000'),
          //   height: 2,
          //   endIndent: 5,
          //   indent: 0.5,
          //   borderStyle: pw.BorderStyle.solid,
          // ),
        ],
      );
    }

    pw.Widget bodyLetter() {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: double.infinity,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    "Laporan Perjalanan Dinas",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
                itemData("No. Surat Tugas", letterModel.nomorSurat),
                itemData("Yang Memberi Perintah", letterModel.pemberiPerintah),
                itemData("Maksud Perjalanan Dinas", letterModel.keterangan),
                itemData("Tujuan Perjalanan Dinas", letterModel.lokasiTujuan),
                itemData(
                  "Lama Penugasan",
                  "${daysLengt(letterModel.tglAwal, letterModel.tglAkhir).toString()} Hari, ${DateFormat('dd MMM yyyy', 'id_ID').format(letterModel.tglAwal)} - ${DateFormat('dd MMM yyyy', 'id_ID').format(letterModel.tglAkhir)}",
                ),
                itemListData(
                    "Anggota Yang Mengikuti", letterModel.anggotaMengikuti),
                // itemListBullet("Anggota", letterModel.anggotaMengikuti),
              ],
            ),
          ),
        ],
      );
    }

    pw.Widget footer() {
      return pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.only(right: 30),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    "Sofifi, ${DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now())}",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Yang Melapor',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.SizedBox(height: 80),
                  pw.Text(
                    letterModel.userId.name,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  pw.Text(
                    "NIP. ${userModel.nip}",
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          )

          //**
          // child: pw.Column(
          //   crossAxisAlignment: pw.CrossAxisAlignment.start,
          //   children: [
          //     pw.SizedBox(height: 16),
          //     pw.Row(
          //       mainAxisAlignment: pw.MainAxisAlignment.center,
          //       children: [
          //         pw.Text(
          //           "Dibuat Oleh",
          //           style: pw.TextStyle(
          //             fontSize: 14,
          //             fontWeight: pw.FontWeight.normal,
          //           ),
          //         ),
          //         pw.Spacer(),
          //         pw.Text(
          //           "Diketahui Oleh",
          //           style: pw.TextStyle(
          //             fontSize: 14,
          //             fontWeight: pw.FontWeight.normal,
          //           ),
          //         ),
          //       ],
          //     ),
          //     pw.SizedBox(height: 75),
          //     pw.Row(
          //       mainAxisAlignment: pw.MainAxisAlignment.center,
          //       children: [
          //         pw.Text(
          //           "(${letterModel.userId.name})",
          //           style: pw.TextStyle(
          //             fontSize: 14,
          //             fontWeight: pw.FontWeight.normal,
          //           ),
          //         ),
          //         pw.Spacer(),
          //         pw.Text(
          //           "(${letterModel.userId.name})",
          //           style: pw.TextStyle(
          //             fontSize: 14,
          //             fontWeight: pw.FontWeight.normal,
          //           ),
          //         ),
          //       ],
          //     ),
          //     pw.SizedBox(height: 4),
          //     pw.Row(
          //       mainAxisAlignment: pw.MainAxisAlignment.center,
          //       children: [
          //         pw.Text(
          //           "(${letterModel.pemberiPerintah})",
          //           style: pw.TextStyle(
          //             fontSize: 14,
          //             fontWeight: pw.FontWeight.normal,
          //           ),
          //         ),
          //         pw.Spacer(),
          //       ],
          //     )
          //   ],
          // ),
          );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 45, vertical: 45),
        orientation: pw.PageOrientation.portrait,
        build: (context) {
          return pw.Column(
            children: [
              header(),
              pw.SizedBox(height: 8),
              bodyLetter(),
              pw.Spacer(),
              footer(),
            ],
          );
        },
      ),
    );

    //* Kegiatan Perjalanan Dinas Page ========================================
    pw.Widget bodyActivity(ReportModel reportModel, String address) {
      return pw.Container(
        width: double.infinity,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: double.infinity,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "Laporan Kegiatan Perjalanan Dinas",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  itemData("Nama Kegiatan", reportModel.namaKegiatan),
                  itemData(
                    "Waktu",
                    DateFormat('dd MMMM yyyy - hh:mm', 'id_ID')
                        .format(reportModel.createdAt),
                  ),
                  itemData("Notulen Kegiatan", reportModel.deskripsi),
                  itemData("Lokasi Kegiatan", address),
                  itemData("Lampiran Dokumentasi", ''),
                  pw.SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      );
    }

    pw.Widget attachment(String kegiatan) {
      return pw.Container(
        width: double.infinity,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
              width: double.infinity,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "Lampiran Foto Kegiatan",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Center(
                    child: pw.Text(
                      kegiatan,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      );
    }

    pw.Widget photoAttach(List attachment) {
      return pw.Container(
        width: double.infinity,
        child: pw.Wrap(
            direction: pw.Axis.horizontal,
            runSpacing: 16,
            spacing: 12,
            alignment: pw.WrapAlignment.start,
            children: attachment
                .map((e) => pw.Image(
                      pw.MemoryImage(e),
                      height: 160,
                      width: 170,
                      fit: pw.BoxFit.fitWidth,
                    ))
                .toList()),
      );
    }

    for (var i = 0; i < reportModel.length; i++) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 25, vertical: 45),
          orientation: pw.PageOrientation.portrait,
          build: (context) {
            return [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: header(),
              ),
              pw.SizedBox(height: 8),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: bodyActivity(reportModel[i], address[i]),
              ),
              // attachment(),
              photoAttach(imageGroup[i]),
            ];
          },
        ),
      );
      // pdf.addPage(
      //   pw.MultiPage(
      //     pageFormat: PdfPageFormat.a4,
      //     margin: const pw.EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      //     orientation: pw.PageOrientation.portrait,
      //     build: (context) {
      //       return [
      //         // pw.Padding(
      //         //   padding: const pw.EdgeInsets.symmetric(horizontal: 20),
      //         //   child: header(),
      //         // ),
      //         attachment(reportModel[i].namaKegiatan),
      //         photoAttach(imageGroup[i]),
      //       ];
      //     },
      //   ),
      // );
    }

    return pdf.save();
  }
}
