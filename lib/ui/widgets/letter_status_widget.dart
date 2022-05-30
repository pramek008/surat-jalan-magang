import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class LetterStatusWidget extends StatelessWidget {
  final bool status;
  const LetterStatusWidget(this.status, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: status ? greenStatusColor : redStatusColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        status ? 'Sedang Berjalan' : 'Selesai',
        style: txRegular.copyWith(
          fontSize: 12,
          color: blackColor,
        ),
      ),
    );
  }
}
