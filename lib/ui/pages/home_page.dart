import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/dummy_data.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/widgets/card_letter_widget.dart';
import 'package:surat_jalan/ui/widgets/card_news_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget timeHeading() {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: Row(
          children: [
            Text(
              DateFormat(
                'EEEE, dd MMMM yyyy  kk:mm ',
                "id_ID",
              ).format(
                DateTime.now(),
              ),
              style: txRegular.copyWith(
                color: greyDeepColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.notifications,
              color: primaryColor,
              size: 30,
            ),
            const SizedBox(
              width: 12,
            ),
            Icon(
              Icons.account_circle,
              color: primaryColor,
              size: 30,
            ),
          ],
        ),
      );
    }

    Widget greetingText() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang,',
              style: txSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
            Text(
              'Stefan Rodrigues',
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    Widget suratPerjalanan() {
      var colors = [
        const Color(0xff006EE9),
        const Color(0xff18DC4F),
        const Color(0xffE9A800),
        const Color(0xffDA4505),
        const Color(0xff9E20D9),
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Text(
              'Surat Perjalanan Dinas',
              style: txSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 10,
                left: defaultMargin,
              ),
              scrollDirection: Axis.horizontal,
              children: dummySurat
                  .map((e) => CardLetterWidget(
                        surat: e,
                        // color: colors[e.id % 2],
                        color: (colors..shuffle()).first,
                      ))
                  .toList(),
            ),
          )
        ],
      );
    }

    Widget berita() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berita',
              style: txSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: const [
                CardNewsWidget(),
                CardNewsWidget(),
                CardNewsWidget(),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgrounColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                runSpacing: 10,
                children: [
                  timeHeading(),
                  greetingText(),
                  suratPerjalanan(),
                  berita(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
