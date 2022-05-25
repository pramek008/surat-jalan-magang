import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class LetterPage extends StatelessWidget {
  const LetterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      body: SafeArea(
        child: Center(
          child: Text('Ini Halaman Surat Jalan'),
        ),
      ),
    );
  }
}
