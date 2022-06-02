import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/letter_tab.dart';

class LetterListPage extends StatelessWidget {
  const LetterListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Terbaru ( 4 )',
                  style: txSemiBold.copyWith(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Selesai ( 2 )',
                  style: txSemiBold.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LetterListTab(),
            LetterListTab(),
          ],
        ),
      ),
    );
  }
}
