import 'package:flutter/material.dart';
import 'package:surat_jalan/dummy_data.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/widgets/card_letter_tile_widget.dart';

class LetterDoneListTab extends StatelessWidget {
  const LetterDoneListTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = [
      const Color(0xff006EE9),
      const Color(0xff18DC4F),
      const Color(0xffE9A800),
      const Color(0xffDA4505),
      const Color(0xff9E20D9),
    ];

    return Scaffold(
      backgroundColor: backgrounColor,
      body: Container(
        // margin: EdgeInsets.only(
        //   left: defaultMargin - 8,
        //   right: defaultMargin - 8,
        // ),
        child: SingleChildScrollView(
          child: Column(
            //* logic penugasan yang SUDAH SELESAI dilakukan
            children: dummySurat
                .where((element) => element.tglAkhir.isBefore(DateTime.now()))
                .map((e) => Container(
                      padding: e ==
                              dummySurat
                                  .where((element) =>
                                      element.tglAkhir.isBefore(DateTime.now()))
                                  .first
                          ? EdgeInsets.only(top: defaultMargin)
                          : const EdgeInsets.only(top: 0),
                      margin: e ==
                              dummySurat
                                  .where((element) =>
                                      element.tglAkhir.isBefore(DateTime.now()))
                                  .last
                          ? EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.1 + 15)
                          : EdgeInsets.only(bottom: defaultMargin),
                      child: CardLetterTileWidget(
                          color: (colors..shuffle()).first, surat: e),
                    ))
                .toList(),
            // [
            // for (var i = 0; i < dummySurat.length; i++)
            //   Container(
            //     padding: i == 0
            //         ? EdgeInsets.only(top: defaultMargin)
            //         : const EdgeInsets.only(top: 0),
            //     margin: i == dummySurat.length - 1
            //         ? const EdgeInsets.only(bottom: 80)
            //         : const EdgeInsets.only(bottom: 0),
            //     child: CardLetterTileWidget(
            //       surat: dummySurat[i],
            //       color: colors[i],
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}
