import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/services/pdf_service.dart';

class PdfPreviewPage extends StatelessWidget {
  final LetterModel letter;
  const PdfPreviewPage({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => generatePdf('Laporan Perjalanan Dinas'),
      ),
    );
  }
}
