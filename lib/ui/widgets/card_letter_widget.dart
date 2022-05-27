import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class CardLetterWidget extends StatelessWidget {
  final Color color;

  const CardLetterWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //*--------------------------------------------------------------------

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
            color: whiteColor.withOpacity(0.15),
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
            bottom: -50,
            right: 95,
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
                    '10 Hari',
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
              'Pelatihan IOT dengan basis Satelit',
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
                  '20 Mei 2022',
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
              'Provinsi Lampung Kabupaten Lampung Selatan',
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
      onTap: () {},
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
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
