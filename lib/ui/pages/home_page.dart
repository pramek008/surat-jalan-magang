import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget timeHeading() {
      return Row(
        children: [
          Text(
            '25 Mei 2022',
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
      );
    }

    Widget greetingText() {
      return Column(
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
              fontSize: 16,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timeHeading(),
                greetingText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
