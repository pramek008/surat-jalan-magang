import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/cubit/report_cubit.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:surat_jalan/shared/shared_value.dart';
import 'package:surat_jalan/ui/pages/activity_report_view.dart';

class CardLaporanWidget extends StatelessWidget {
  final ReportModel report;
  const CardLaporanWidget({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LaporanKegiatanView(
                      report: report,
                    ))).then(
            (value) => BlocProvider.of<ReportCubit>(context).getAllReport());
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
          right: 2,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                // color: blackColor.withOpacity(0.3),
                image: DecorationImage(
                  image: NetworkImage("$baseImageURL/${report.foto.first}"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  report.foto.length.toString(),
                  style: txRegular.copyWith(
                    color: whiteColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMMM yyyy - hh:mm', "id_ID")
                        .format(report.createdAt),
                    style: txRegular.copyWith(
                      fontSize: 12,
                      color: greyIconColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    report.namaKegiatan,
                    style: txMedium.copyWith(
                      fontSize: 20,
                      color: blackColor,
                      height: 1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    report.perintahJalanId.tujuan,
                    style: txRegular.copyWith(
                      fontSize: 12,
                      color: greyIconColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
