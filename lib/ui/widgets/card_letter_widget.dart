import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/letter_page.dart';

class CardLetterWidget extends StatelessWidget {
  final Color color;
  final LetterModel surat;

  const CardLetterWidget({
    Key? key,
    required this.color,
    required this.surat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //*--------------------------------------------------------------------

    int daysLengt(DateTime from, DateTime to) {
      from =
          DateTime(surat.tglAwal.year, surat.tglAwal.month, surat.tglAwal.day);
      to = DateTime(
          surat.tglAkhir.year, surat.tglAkhir.month, surat.tglAkhir.day);
      return to.difference(from).inDays;
    }

    //* Background card with rounded corners decoration
    Widget backgroudCard(Color color) {
      //*This widget is used to create rounded corners
      Widget circleBg(
        double width,
        double height,
        double padding,
        Color colorCircle,
      ) {
        return Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: blackColor.withOpacity(0.15),
          ),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: colorCircle,
            ),
          ),
        );
      }

      return Stack(
        children: [
          Positioned(
            bottom: 20,
            right: -80,
            child: circleBg(100, 100, 17, color),
          ),
          Positioned(
            bottom: 150,
            right: 80,
            child: circleBg(30, 30, 4, color),
          ),
          Positioned(
            bottom: -70,
            left: -50,
            child: circleBg(100, 100, 20, Colors.transparent),
          ),
        ],
      );
    }

    Widget content() {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${daysLengt(surat.tglAwal, surat.tglAkhir).toString()} Hari",
                    style: txRegular.copyWith(
                      color: blackColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 8),
            Text(
              surat.judul,
              style: txSemiBold.copyWith(
                fontSize: 18,
                color: whiteColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                Text(
                  DateFormat('dd MMM yyyy', 'id_ID').format(surat.tglAwal),
                  style: txRegular.copyWith(
                    fontSize: 14,
                    color: whiteColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            Text(
              surat.lokasiTujuan,
              style: txRegular.copyWith(
                fontSize: 14,
                color: whiteColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    //*Master Class
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LetterPage(surat: surat),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            backgroudCard(color),
            content(),
          ],
        ),
      ),
    );
  }
}
