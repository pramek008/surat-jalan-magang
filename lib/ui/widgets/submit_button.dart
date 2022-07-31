import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/shared_theme.dart';

class SubmitButton extends StatelessWidget {
  final bool status;
  final Function onPressed;
  const SubmitButton({
    Key? key,
    required this.status,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: status ? Colors.green.shade600 : Colors.amber.shade600,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status
                  ? Icons.library_add_check_outlined
                  : Icons.file_upload_rounded,
              size: 35,
              color: whiteColor,
            ),
            const SizedBox(width: 10),
            Text(
              status ? 'Laporan Sudah Diserahkan' : 'Serahkan Laporan',
              style: txMedium.copyWith(
                color: whiteColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
