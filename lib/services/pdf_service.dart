import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/models/user_model.dart';
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

    var netImage = await networkImage(
      '$baseImageURL/post-foto/rjvjw6FV2s8wid8VBQzg8DpsoKpmpZ7iFu4fjm7g.jpg',
    );

    List dummyImages = [
      netImage,
      netImage,
      netImage,
    ];

    List imageGroup = [];
    List imageData = [];
    for (var i = 0; i < reportModel.length; i++) {
      imageGroup.add(reportModel[i].foto);
      List byReport = [];
      for (var j = 0; j < reportModel[i].foto.length; j++) {
        byReport.add(reportModel[i].foto[j]);
        final response = await http
            .get(Uri.parse('$baseImageURL/${reportModel[i].foto[j]}'));
        imageData.add(response.bodyBytes);
      }
    }
    print(imageData);

    // final netImage = await networkImage(
    //   'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png',
    // );

    // List<dynamic> imageProviders = [];

    // List<dynamic> loadImage(List<String> images) {
    //   for (var i = 0; i < images.length; i++) {
    //     imageProviders.add(networkImage('$baseImageURL/${images[i]}'));
    //   }
    //   return imageProviders;
    // }

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

    // String getLocation(String lokasi0, String? lokasi1) {
    //   double? lat = double.tryParse(lokasi0);
    //   double? lng = double.tryParse(lokasi0);
    //   String address = LocationService().getAddressFromDb(lat!, lng!).toString();
    //   return address;
    // }
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
    pw.Widget bodyActivity(ReportModel reportModel) {
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
                  itemData("Tempat", reportModel.lokasi.toString()),
                  // itemData("Lampiran", ''),
                  pw.SizedBox(height: 24),
                  // pw.Wrap(
                  //     direction: pw.Axis.horizontal,
                  //     runSpacing: 8,
                  //     spacing: 8,
                  //     children: imageData
                  //         .map((e) => pw.Image(
                  //               pw.MemoryImage(e),
                  //               height: 130,
                  //               width: 130,
                  //               fit: pw.BoxFit.cover,
                  //             ))
                  //         .toList()),

                  // pw.Image(
                  //   netImage,
                  //   height: 200,
                  //   width: 200,
                  //   fit: pw.BoxFit.cover,
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    for (var i = 0; i < reportModel.length; i++) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 45, vertical: 45),
          orientation: pw.PageOrientation.portrait,
          build: (context) {
            return [
              header(),
              pw.SizedBox(height: 8),
              bodyActivity(
                reportModel[i],
              ),
            ];
          },
        ),
      );
    }

    //* Halaman Lampiran Foto
    pw.Widget attachment(List attachment) {
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
                      "Lampiran Foto",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Wrap(
                      direction: pw.Axis.horizontal,
                      runSpacing: 16,
                      spacing: 8,
                      alignment: pw.WrapAlignment.center,
                      children: imageData
                          .map((e) => pw.Image(
                                pw.MemoryImage(e),
                                height: 150,
                                width: 150,
                                fit: pw.BoxFit.cover,
                              ))
                          .toList()),
                ],
              ),
            ),
          ],
        ),
      );
    }

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 45, vertical: 45),
      orientation: pw.PageOrientation.portrait,
      build: (context) {
        return [
          attachment(imageData),
        ];
      },
    ));

    return pdf.save();
  }
}
