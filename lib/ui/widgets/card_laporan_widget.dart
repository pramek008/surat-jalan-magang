import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/models/report_model.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/laporan_kegiatan_view.dart';

class CardLaporanWidget extends StatelessWidget {
  final ReportModel report;
  const CardLaporanWidget({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LaporanKegiatanView(
                      report: report,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
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
                  image: const NetworkImage(
                      'https://asset.kompas.com/crops/FBV7gpKwzXO27w799K6Wwyd6S14=/0x0:1920x1280/750x500/data/photo/2020/03/14/5e6cbeeb23f01.jpg'),
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
                    report.lokasi.toString(),
                    style: txRegular.copyWith(
                      fontSize: 12,
                      color: greyIconColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
