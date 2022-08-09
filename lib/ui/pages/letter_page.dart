import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:surat_jalan/bloc/auth_bloc.dart';
import 'package:surat_jalan/bloc/letter_bloc.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:surat_jalan/ui/pages/add_activity_report_page.dart';
import 'package:surat_jalan/ui/pages/pdf_preview_page.dart';
import 'package:surat_jalan/ui/widgets/card_report_widget.dart';
import 'package:surat_jalan/ui/widgets/letter_status_widget.dart';
import 'package:surat_jalan/ui/widgets/loading_dialog_widget.dart';
import 'package:surat_jalan/ui/widgets/submit_button.dart';

import '../../cubit/report_cubit.dart';

class LetterPage extends StatefulWidget {
  final LetterModel surat;

  const LetterPage({
    Key? key,
    required this.surat,
  }) : super(key: key);

  @override
  State<LetterPage> createState() => _LetterPageState();
}

class _LetterPageState extends State<LetterPage> {
  //* Fetch all report from server
  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().getAllReport();
    context.read<AuthBloc>().add(AuthLoadUserEvent());
  }

  //* Untuk memeriksa status surat apakah masih berjalan atau sudah selesai
  bool isExpired(DateTime tglAkhir) {
    var lastday = DateTime.now().subtract(const Duration(days: 1));
    if (lastday.isAfter(tglAkhir)) {
      return false;
    } else {
      return true;
    }
  }

  //* Untuk memeriksa apakah ada anggota lain yang mengikuti penugasan
  bool tanpaPengikut(List pengikut) {
    if (pengikut.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  //* Untuk menghitung jumlah hari sebelum tanggal selesai
  int daysLengt(DateTime to) {
    DateTime nowDate = DateTime.now();
    to = DateTime(widget.surat.tglAkhir.year, widget.surat.tglAkhir.month,
        widget.surat.tglAkhir.day + 1);
    return to.difference(nowDate).inDays;
  }

  //* Untuk menghitung jumlah jam sebelum tanggal selesai
  int hoursLeft(DateTime to) {
    DateTime nowDate = DateTime.now();
    to = DateTime(widget.surat.tglAkhir.year, widget.surat.tglAkhir.month,
        widget.surat.tglAkhir.day);
    int manyHour = to.difference(nowDate).inHours;
    int hourLastDay = manyHour % 24;
    return hourLastDay;
  }

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;

    Widget heading() {
      return Padding(
        padding: EdgeInsets.only(
          top: defaultMargin / 2,
          bottom: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: AutoSizeText(
                widget.surat.judul,
                style: txBold.copyWith(
                  color: blackColor,
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
            ),
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
                  widget.surat.nomorSurat,
                  style: txRegular.copyWith(
                    color: blackColor,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const Spacer(),

            //!! Status Condition
            LetterStatusWidget(isExpired(widget.surat.tglAkhir)),
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
              widget.surat.pemberiPerintah,
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
              widget.surat.userId.name,
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
              children: tanpaPengikut(widget.surat.anggotaMengikuti) == true
                  ? widget.surat.anggotaMengikuti.map((e) {
                      return anggotaItem(e);
                    }).toList()
                  : [
                      anggotaItem('Tidak Ada Anggota Mengikuti'),
                    ],
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
              widget.surat.lokasiTujuan,
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
                  ).format(widget.surat.tglAwal),
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
                  ).format(widget.surat.tglAkhir),
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
                          isExpired(widget.surat.tglAkhir)
                              ? daysLengt(widget.surat.tglAkhir).toString()
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
                          isExpired(widget.surat.tglAkhir)
                              ? hoursLeft(widget.surat.tglAkhir).toString()
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
              widget.surat.keterangan,
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
              'Laporan Perjalanan Dinas :',
              style: txSemiBold.copyWith(
                fontSize: 20,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 12),

            //* List Card Laporan Perjalanan Dinas
            BlocConsumer<ReportCubit, ReportState>(
              listener: (context, state) {
                if (state is ReportResponse) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.response.message,
                        style: txRegular.copyWith(
                          color: whiteColor,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: redStatusColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ReportLoaded) {
                  double length = double.parse(state.reports
                      .where((element) =>
                          element.perintahJalanId.id == widget.surat.id)
                      .length
                      .toString());
                  if (state.reports
                      .where((element) =>
                          element.perintahJalanId.id == widget.surat.id)
                      .isEmpty) {
                    _isEmpty = true;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Belum ada laporan yang anda buat',
                          style: txMedium.copyWith(
                            fontSize: 16,
                            color: greyDeepColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    height: 120 * length,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: state.reports
                          .where((element) =>
                              element.perintahJalanId.id == widget.surat.id)
                          .length,
                      itemBuilder: (context, index) {
                        List item = state.reports
                            .where((element) =>
                                element.perintahJalanId.id == widget.surat.id)
                            .toList();
                        final report = item[index];
                        return Dismissible(
                          key: Key(report.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: redStatusColor),
                            child: Icon(
                              Icons.delete,
                              color: whiteColor,
                              size: 30,
                            ),
                          ),
                          confirmDismiss: (direction) {
                            return showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Hapus Laporan',
                                      style: txSemiBold.copyWith(fontSize: 22)),
                                  content: const Text(
                                    'Apakah anda yakin ingin menghapus laporan ini?',
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: greyThinColor,
                                          ),
                                          child: Text(
                                            'Tidak',
                                            style: txMedium.copyWith(
                                                color: blackColor),
                                          )),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: redStatusColor,
                                        ),
                                        child: Text(
                                          'Ya',
                                          style: txMedium.copyWith(
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              context.read<ReportCubit>().deleteReport(state
                                  .reports
                                  .where((element) =>
                                      element.perintahJalanId.id ==
                                      widget.surat.id)
                                  .elementAt(index)
                                  .id);
                              // Navigator.of(context).pop();
                              setState(() {
                                item.removeAt(index);
                                context.read<ReportCubit>().getAllReport();
                                // length = double.parse(item.length.toString());
                              });
                            }
                          },
                          child: CardLaporanWidget(report: item[index]),
                        );
                      },
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            widget.surat.diserahkan == true
                ? Container(
                    margin: const EdgeInsets.only(bottom: 35),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LaporanKegiatanAddPage(
                                userId: widget.surat.userId.id,
                                suratJalanId: widget.surat.id,
                              ),
                            ),
                          ).then((value) =>
                              {context.read<ReportCubit>().getAllReport()});
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

      //* on progress belum tau diapakai atau tidak
      Widget exportPdf() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PdfPreviewPage(letter: widget.surat)));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
                child: Text(
                  'Export PDF',
                  style: txSemiBold.copyWith(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      }

      //* penyerahan laporan
      Widget serahkanLaporan() {
        return BlocListener<LetterBloc, LetterState>(
          listener: (context, state) {
            if (state is LetterSuccessState) {
              if (state.response.status.toString() == "success") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Laporan berhasil diserahkan",
                      style: txRegular.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    backgroundColor: greenStatusColor,
                  ),
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            } else if (state is LetterLoadingState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       "Loading...",
              //       style: txRegular.copyWith(
              //         color: whiteColor,
              //       ),
              //     ),
              //     backgroundColor: greenStatusColor,
              //   ),
              // );
              showDialog(
                  context: context,
                  builder: (context) =>
                      const LoadingDialogWidget('Loading...'));
            } else if (state is LetterFailureState) {
              if (state.response.status.toString() == "gagal") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Gagal diserahkan",
                      style: txRegular.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    backgroundColor: redStatusColor,
                  ),
                );
              }
            }
          },
          child: SubmitButton(
            status: widget.surat.diserahkan,
            onPressed: () {
              if (_isEmpty == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tidak dapat menyerahkan laporan kosong'),
                  ),
                );
              } else if (widget.surat.diserahkan == false) {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Serahkan Laporan',
                          style: txSemiBold.copyWith(fontSize: 22)),
                      content: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Apakah anda yakin untuk menyerahkan laporan ?',
                              style: txRegular.copyWith(
                                color: greyDeepColor,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n\nSetelah diserahkan anda tidak dapat lagi mengubah laporan.',
                              style: txMedium.copyWith(
                                color: redStatusColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor,
                              ),
                              child: Text(
                                'Yakin',
                                style: txMedium.copyWith(color: whiteColor),
                              )),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            context.read<LetterBloc>().add(LetterPutEvent(
                                  id: widget.surat.id,
                                  userId: widget.surat.userId.id,
                                  judul: widget.surat.judul,
                                  nomorSurat: widget.surat.nomorSurat,
                                  pemberiPerintah: widget.surat.pemberiPerintah,
                                  anggotaMengikuti:
                                      widget.surat.anggotaMengikuti,
                                  lokasiTujuan: widget.surat.lokasiTujuan,
                                  keterangan: widget.surat.keterangan,
                                  tglAwal: widget.surat.tglAwal,
                                  tglAkhir: widget.surat.tglAkhir,
                                  diserahkan: true,
                                ));
                          },
                        ),
                        TextButton(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: greyThinColor,
                            ),
                            child: Text(
                              'Tidak',
                              style: txMedium.copyWith(color: blackColor),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Laporan anda sudah diserahkan'),
                  ),
                );
              }
            },
          ),
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
          exportPdf(),
          serahkanLaporan(),
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
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
