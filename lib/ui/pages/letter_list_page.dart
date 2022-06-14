import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/cubit/report_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/letter_tabs/letter_done_tab.dart';
import 'package:surat_jalan/ui/pages/letter_tabs/letter_onprogress_tab.dart';

class LetterListPage extends StatefulWidget {
  const LetterListPage({Key? key}) : super(key: key);

  @override
  State<LetterListPage> createState() => _LetterListPageState();
}

class _LetterListPageState extends State<LetterListPage> {
  @override
  void initState() {
    context.read<LetterCubit>().getAllLetter();
    context.read<ReportCubit>().getAllReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LetterCubit, LetterState>(
      builder: (context, state) {
        if (state is LetterLoaded) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Surat Jalan',
                  style: txSemiBold.copyWith(fontSize: 20),
                ),
                backgroundColor: primaryColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                shadowColor: Colors.black38,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: whiteColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: whiteColor.withOpacity(0.5),
                  tabs: [
                    Tab(
                      child: Text(
                        // 'Terbaru ( ${dummySurat.where((element) => element.tglAkhir.isAfter(DateTime.now())).length} )',
                        'Terbaru ( ${state.letters.where((element) => element.tglAkhir.isAfter(DateTime.now())).length} )',
                        style: txSemiBold.copyWith(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        // 'Selesai ( ${dummySurat.where((element) => element.tglAkhir.isBefore(DateTime.now())).length} )',
                        'Selesai ( ${state.letters.where((element) => element.tglAkhir.isBefore(DateTime.now())).length} )',
                        style: txSemiBold.copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  LetterOnProgressListTab(),
                  LetterDoneListTab(),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
