// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/cubit/page_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/pages/home_page.dart';
import 'package:surat_jalan/ui/pages/letter_list_page.dart';
import 'package:surat_jalan/ui/widgets/navbar_item_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int index) {
      switch (index) {
        case 0:
          return const HomePage();
        case 1:
          return LetterListPage();
        default:
          return const HomePage();
      }
    }

    Widget buildButtonNav() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItemWidget(
                imgUrl: 'assets/icon_home.png',
                title: 'Home',
                index: 0,
              ),
              NavBarItemWidget(
                imgUrl: 'assets/icon_letter.png',
                title: 'Surat',
                index: 1,
              )
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgrounColor,
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              backgroundColor: greyIconColor,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Tekan sekali lagi untuk keluar',
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  buildContent(state),
                  buildButtonNav(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
