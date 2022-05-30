import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/widgets/card_letter_tile_widget.dart';

class LetterListTab extends StatelessWidget {
  const LetterListTab({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardLetterTileWidget(color: (colors..shuffle()).first),
              CardLetterTileWidget(color: (colors..shuffle()).first),
              CardLetterTileWidget(color: (colors..shuffle()).first),
            ],
          ),
        ),
      ),
    );
  }
}
