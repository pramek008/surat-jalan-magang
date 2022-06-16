import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/news_model.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/account_page.dart';
import 'package:surat_jalan/ui/widgets/card_letter_widget.dart';
import 'package:surat_jalan/ui/widgets/card_news_widget.dart';

import '../../cubit/news_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<LetterCubit>().getAllLetter();
    // context.read<ReportCubit>().getAllReport();
    context.read<NewsCubit>().getAllNews();
    super.initState();
  }

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
                fontSize: 14,
              ),
            ),
            const Spacer(),
            // Icon(
            //   Icons.notifications,
            //   color: primaryColor,
            //   size: 30,
            // ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountPage(),
                  ),
                );
              },
              child: Icon(
                Icons.account_circle,
                color: primaryColor,
                size: 40,
              ),
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

    Widget suratPerjalanan(List<LetterModel> letter) {
      var colors = [
        const Color(0xff006EE9),
        const Color(0xff18DC4F),
        const Color(0xffE9A800),
        const Color(0xffDA4505),
        const Color(0xff9E20D9),
      ];
      if (letter.isEmpty) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Perjalanan',
                style: txSemiBold.copyWith(
                  color: blackColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Tidak ada surat perjalanan',
                style: txMedium.copyWith(
                  color: redStatusColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      }

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
              children: letter
                  .map((e) => CardLetterWidget(
                        surat: e,
                        color: (colors..shuffle()).first,
                      ))
                  .toList(),
            ),
          )
        ],
      );
    }

    Widget berita(List<NewsModel> news) {
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
              children: news
                  .map((e) => CardNewsWidget(
                        news: e,
                      ))
                  .toList(),
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
                // runAlignment: WrapAlignment.start,
                // alignment: WrapAlignment.start,
                children: [
                  timeHeading(),
                  greetingText(),
                  BlocBuilder<LetterCubit, LetterState>(
                    builder: (context, state) {
                      if (state is LetterInitial) {
                        context.read<LetterCubit>().getAllLetter();
                      } else if (state is LetterLoaded) {
                        return suratPerjalanan(state.letters);
                      } else if (state is LetterError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Surat Perjalanan Dinas',
                              style: txSemiBold.copyWith(
                                color: blackColor,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                                height: 220,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<NewsCubit, NewsState>(
                    builder: (context, state) {
                      if (state is NewsInitial) {
                        context.read<NewsCubit>().getAllNews();
                      } else if (state is NewsLoaded) {
                        return berita(state.news);
                      } else if (state is NewsError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
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
                                height: 220,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ],
                        ),
                      );
                    },
                  ),
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
