import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/dummy_surat.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/widgets/card_letter_tile_widget.dart';

class LetterOnProgressListTab extends StatelessWidget {
  const LetterOnProgressListTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = [
      const Color(0xff006EE9),
      const Color(0xff1BDC51),
      const Color(0xffDA4505),
      const Color(0xff9E20D9),
    ];

    return Scaffold(
      backgroundColor: backgrounColor,
      body: Container(
        // padding: EdgeInsets.only(
        //   left: defaultMargin,
        //   right: defaultMargin,
        // ),
        child: BlocConsumer<LetterCubit, LetterState>(
          listener: (context, state) {
            if (state is LetterError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            if (state is LetterLoaded) {
              return SingleChildScrollView(
                child: Column(
                  //* logic penugasan yang SEDANG dilakukan
                  children: state.letters
                      .where(
                          (element) => element.tglAkhir.isAfter(DateTime.now()))
                      .map((e) => Container(
                            padding: e ==
                                    state.letters
                                        .where((element) => element.tglAkhir
                                            .isAfter(DateTime.now()))
                                        .first
                                ? EdgeInsets.only(
                                    top: defaultMargin,
                                    bottom: defaultMargin,
                                  )
                                : EdgeInsets.only(bottom: defaultMargin),
                            margin: e ==
                                    state.letters
                                        .where((element) => element.tglAkhir
                                            .isAfter(DateTime.now()))
                                        .last
                                ? EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.1)
                                : const EdgeInsets.only(bottom: 0),
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
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
