import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/pdf_service.dart';

class PdfPreviewPage extends StatelessWidget {
  final LetterModel letter;
  final UserModel user;
  const PdfPreviewPage({Key? key, required this.letter, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(letter, user),
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'Laporan_SPPD_${letter.userId.name}.pdf',
      ),
    );
  }
}
