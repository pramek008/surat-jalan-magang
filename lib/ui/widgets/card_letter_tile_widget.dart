import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/letter_page.dart';

class CardLetterTileWidget extends StatelessWidget {
  final Color color;

  const CardLetterTileWidget({Key? key, required this.color}) : super(key: key);

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
        Color color,
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
              color: color,
            ),
          ),
        );
      }

      return Stack(
        children: [
          Positioned(
            top: -20,
            left: -30,
            child: circleBg(60, 60, 17, Colors.transparent),
          ),
          Positioned(
            bottom: -20,
            left: 100,
            child: circleBg(50, 50, 7, color),
          ),
          Positioned(
            top: -15,
            right: 130,
            child: circleBg(30, 30, 4, color),
          ),
          Positioned(
            top: -30,
            right: -25,
            child: circleBg(80, 80, 20, Colors.transparent),
          ),
        ],
      );
    }

    Widget content() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '001.SPPD/Kec.8.8/SD/2021',
                    style: txRegular.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pelatihan SOT Dalam Rangka Motor',
                    style: txSemiBold.copyWith(
                      fontSize: 20,
                      color: whiteColor,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    'Lokasi :',
                    style: txRegular.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                      height: 1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Provinsi Lampung Utara Barat',
                    style: txRegular.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 5,
                        color: whiteColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '4',
                        style: txBold.copyWith(
                          fontSize: 16,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Berakhir : ',
                        style: txMedium.copyWith(
                          fontSize: 14,
                          color: whiteColor,
                        ),
                      ),
                      Text(
                        '22 Mei 2022',
                        style: txMedium.copyWith(
                          fontSize: 14,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LetterPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        height: 140,
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
