import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/cubit/report_cubit.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:surat_jalan/ui/pages/letter_page.dart';

import '../../cubit/letter_cubit.dart';

class CardLetterTileWidget extends StatelessWidget {
  final Color color;
  final LetterModel surat;

  const CardLetterTileWidget({
    Key? key,
    required this.color,
    required this.surat,
  }) : super(key: key);

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
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surat.nomorSurat,
                    style: txRegular.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    surat.judul,
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
                    surat.lokasiTujuan,
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
              flex: 2,
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
                      child: BlocBuilder<ReportCubit, ReportState>(
                        builder: (context, state) {
                          if (state is ReportLoaded) {
                            return Text(
                              '${state.reports.where((element) => element.perintahJalanId.id == surat.id).length}',
                              style: txSemiBold.copyWith(
                                fontSize: 20,
                                color: whiteColor,
                              ),
                            );
                          } else {
                            return Text(
                              '...',
                              style: txSemiBold.copyWith(
                                fontSize: 20,
                                color: whiteColor,
                              ),
                            );
                          }
                          // return Text(
                          //   '4',
                          //   style: txBold.copyWith(
                          //     fontSize: 16,
                          //     color: whiteColor,
                          //   ),
                          // );
                        },
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
                        DateFormat('dd MMMM yyyy', 'id_ID')
                            .format(surat.tglAkhir),
                        style: txMedium.copyWith(
                          fontSize: 14,
                          color: whiteColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

    //! Main Widget
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LetterPage(surat: surat),
          ),
        )
            .then(
                (value) => BlocProvider.of<LetterCubit>(context).getAllLetter())
            .then((value) =>
                BlocProvider.of<ReportCubit>(context).getAllReport());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(3, 2),
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
