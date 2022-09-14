import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:surat_jalan/models/information_model.dart';
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/news_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/information_service.dart';
import 'package:surat_jalan/shared/shared_theme.dart';
import 'package:surat_jalan/shared/shared_value.dart';
import 'package:surat_jalan/ui/pages/account_page.dart';
import 'package:surat_jalan/ui/widgets/card_letter_widget.dart';
import 'package:surat_jalan/ui/widgets/card_news_widget.dart';

import '../../bloc/auth_bloc.dart';
import '../../cubit/letter_cubit.dart';
import '../../cubit/news_cubit.dart';
import '../../cubit/report_cubit.dart';
import '../../services/secure_storage_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<LetterCubit>().getAllLetter();
    context.read<ReportCubit>().getAllReport();
    context.read<AuthBloc>().add(AuthLoadUserEvent());
    context.read<NewsCubit>().getAllNews();
    _onAllertShow(context);
    super.initState();
  }

  _onAllertShow(context) async {
    InformationModel informationData =
        await InformationService().getInformationFromStorage();

    final allertKredential = await SecureStorageService.storage
        .read(key: SecureStorageService.allertCredential);

    // print(baseImageURL + '/' + informationData.logoMain!);

    String urlImage = (baseImageURL + '/' + informationData.logoMain!);

    bool showAlert(DateTime start, DateTime end) {
      var thisday = DateTime.now();
      if (thisday.isAfter(start) && thisday.isBefore(end)) {
        if (allertKredential != null) {
          return false;
        } else {
          InformationService.credentialAllert();
          return true;
        }
      } else {
        return false;
      }
    }

    print(
        "berlaku ${showAlert(informationData.startedAt!, informationData.expiredAt!)}");
    print('status kredential $allertKredential');

    showAlert(informationData.startedAt!, informationData.expiredAt!)
        ? Alert(
            context: context,
            title: "\n${informationData.appInfo}",
            image: Image.network(
              urlImage,
              height: 300,
              fit: BoxFit.cover,
            ),
            style: AlertStyle(
              titleStyle: txMedium.copyWith(fontSize: 16),
              isButtonVisible: false,
              alertElevation: 5,
            ),
          ).show()
        : null;
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
                    builder: (context) => const AccountPage(),
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

    Widget greetingText(UserModel user) {
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
              user.name,
              style: txRegular.copyWith(
                color: blackColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    Widget suratPerjalanan(List<LetterModel> letter, UserModel user) {
      var lastday = DateTime.now().subtract(const Duration(days: 1));
      var letterByUser =
          letter.where((element) => element.userId.id == user.id).toList();
      letterByUser.sort((a, b) => b.tglAkhir.compareTo(a.tglAkhir));
      var colors = [
        const Color(0xff006EE9),
        const Color(0xff18DC4F),
        const Color(0xffE9A800),
        const Color(0xffDA4505),
        const Color(0xff9E20D9),
      ];
      if (letterByUser.isEmpty) {
        return Container(
          margin: EdgeInsets.symmetric(
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
                height: 16,
              ),
              SizedBox(
                height: 220,
                child: Center(
                  child: Text(
                    'Tidak ada surat perjalanan',
                    style: txMedium.copyWith(
                      color: redStatusColor,
                      fontSize: 20,
                    ),
                  ),
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
              children: letterByUser
                  .map((e) => CardLetterWidget(
                        surat: e,
                        color:
                            e.tglAkhir.isAfter(lastday) ? colors[1] : colors[3],
                        // color: (colors..shuffle()).first,
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
                children: [
                  //* Time Heading
                  timeHeading(),

                  //* Greeting Text
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthAuthenticatedState) {
                        return greetingText(state.user);
                      }
                      return const SizedBox();
                    },
                  ),

                  //* Surat Perjalanan Dinas
                  BlocBuilder<LetterCubit, LetterState>(
                    builder: (context, state) {
                      if (state is LetterInitial) {
                        context.read<LetterCubit>().getAllLetter();
                      } else if (state is LetterLoaded) {
                        context.read<AuthBloc>().add(AuthLoadUserEvent());
                        return BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, authState) {
                            if (authState is AuthAuthenticatedState) {
                              return suratPerjalanan(
                                  state.letters, authState.user);
                            }
                            return const SizedBox();
                          },
                        );
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
                            SizedBox(
                                height: 220,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: primaryColor,
                                ))),
                          ],
                        ),
                      );
                    },
                  ),

                  //* Berita
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
                            SizedBox(
                                height: 220,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: primaryColor,
                                ))),
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
