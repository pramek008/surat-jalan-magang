import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/models/surat_model.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/laporan_kegiatan_page.dart';
import 'package:surat_jalan/ui/widgets/card_laporan_widget.dart';
import 'package:surat_jalan/ui/widgets/letter_status_widget.dart';

class LetterPage extends StatelessWidget {
  final SuratModel surat;

  const LetterPage({
    Key? key,
    required this.surat,
  }) : super(key: key);

  //* Untuk memeriksa status surat apakah masih berjalan atau sudah selesai
  bool isExpired(DateTime tglAkhir) {
    DateTime now = DateTime.now();
    if (now.isAfter(tglAkhir)) {
      return false;
    } else {
      return true;
    }
  }

  //* Untuk memeriksa apakah ada anggota lain yang mengikuti penugasan
  bool tanpaPengikut(List pengikut) {
    if (pengikut.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  //* Untuk menghitung jumlah hari sebelum tanggal selesai
  int daysLengt(DateTime to) {
    DateTime nowDate = DateTime.now();
    to =
        DateTime(surat.tglAkhir.year, surat.tglAkhir.month, surat.tglAkhir.day);
    return to.difference(nowDate).inDays;
  }

  //* Untuk menghitung jumlah jam sebelum tanggal selesai
  int hoursLeft(DateTime to) {
    DateTime nowDate = DateTime.now();
    to =
        DateTime(surat.tglAkhir.year, surat.tglAkhir.month, surat.tglAkhir.day);
    int manyHour = to.difference(nowDate).inHours;
    int hourLastDay = manyHour % 24;
    return hourLastDay;
  }

  @override
  Widget build(BuildContext context) {
    Widget heading() {
      return Padding(
        padding: EdgeInsets.only(
          top: defaultMargin / 2,
          bottom: 10,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                surat.maksudPerjalanan,
                style: txBold.copyWith(
                  color: primaryColor,
                  fontSize: 28,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.disabled_by_default_rounded,
                  color: primaryColor,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      //* nomor surat
      Widget nomorSurat() {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nomor Surat',
                  style: txMedium.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  surat.nomorSurat,
                  style: txRegular.copyWith(
                    color: blackColor,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const Spacer(),

            //!! Status Condition
            LetterStatusWidget(isExpired(surat.tglAkhir)),
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 10,
            //     vertical: 5,
            //   ),
            //   decoration: BoxDecoration(
            //     color: greenStatusColor,
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(10),
            //     ),
            //   ),
            //   child: Text(
            //     'Sedang Berjalan',
            //     style: txRegular.copyWith(
            //       fontSize: 12,
            //       color: blackColor,
            //     ),
            //   ),
            // )
          ],
        );
      }

      //* pemberi perintah
      Widget pemberiPerintah() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yang Memberi Perintah',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              surat.pemberiPerintah,
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      //* yang diberi perintah
      Widget diberiPerintah() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yang Diberi Perintah',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              surat.penerimaPerintah,
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      //* anggota yang mengikuti
      Widget anggotaMengikuti() {
        //* anggota item dot
        Widget anggotaItem(String nama) {
          return Row(
            children: [
              Icon(
                Icons.circle,
                color: blackColor,
                size: 8,
              ),
              const SizedBox(width: 5),
              Text(
                nama,
                style: txRegular.copyWith(
                  color: blackColor,
                  fontSize: 14,
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Anggota Yang Mengikuti : ',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              runSpacing: 5,
              children: tanpaPengikut(surat.anggotaMengikuti) == true
                  ? surat.anggotaMengikuti.map((e) {
                      return anggotaItem(e);
                    }).toList()
                  : [
                      anggotaItem('Tidak Ada Anggota Mengikuti'),
                    ],
              // [
              //   anggotaItem('Ekaaaaa'),
              //   anggotaItem('Ekaaaaa'),
              //   anggotaItem('Ekaaaaa'),
              //   anggotaItem('Ekaaaaa'),
              // ],
            )
          ],
        );
      }

      //* lokasi penugasan
      Widget lokasiPenugasan() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi Penugasan : ',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              surat.lokasiTujuan,
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      //* tanggal penugasan
      Widget tanggalPenugasan() {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal Mulai : ',
                  style: txMedium.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat(
                    'dd MMMM yyyy',
                    "id_ID",
                  ).format(surat.tglAwal),
                  style: txRegular.copyWith(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal Selesai : ',
                  style: txMedium.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat(
                    'dd MMMM yyyy',
                    "id_ID",
                  ).format(surat.tglAkhir),
                  style: txRegular.copyWith(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        );
      }

      //* day countdown
      Widget dayCountdown() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sisa Hari : ',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          // daysLengt(surat.tglAkhir).toString(),
                          isExpired(surat.tglAkhir)
                              ? daysLengt(surat.tglAkhir).toString()
                              : '0',
                          style: txBold.copyWith(
                            color: whiteColor,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Hari',
                          style: txBold.copyWith(
                            color: whiteColor,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 15,
                  height: 5,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          // hoursLeft(surat.tglAkhir).toString(),
                          isExpired(surat.tglAkhir)
                              ? hoursLeft(surat.tglAkhir).toString()
                              : '0',
                          style: txBold.copyWith(
                            color: whiteColor,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Jam',
                          style: txBold.copyWith(
                            color: whiteColor,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }

      //* deskripsi penugasan
      Widget deskripsiPenugasan() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi Penugasan : ',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              surat.keterangan,
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      //* laporan perjalanan dinas
      Widget laporanPerjalananDinas() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Laporan Perjalanan Dinas : ',
              style: txMedium.copyWith(
                fontSize: 16,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 12),

            //* List Card Laporan Perjalanan Dinas
            Column(
              children: const [
                CardLaporanWidget(),
                CardLaporanWidget(),
                // CardLaporanWidget(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LaporanKegiatanPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add_box_rounded,
                    size: 60,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        );
      }

      //! MASTER Widget Content (untuk menampung semua widget component)
      return Wrap(
        runSpacing: 16,
        children: [
          nomorSurat(),
          pemberiPerintah(),
          diberiPerintah(),
          anggotaMengikuti(),
          lokasiPenugasan(),
          tanggalPenugasan(),
          dayCountdown(),
          deskripsiPenugasan(),
          laporanPerjalananDinas(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgrounColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: defaultMargin,
            left: defaultMargin,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                heading(),
                content(),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
