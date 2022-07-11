import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/cubit/theme_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';

import '../../services/secure_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _remindUser();
    super.initState();
  }

  Future<void> _remindUser() async {
    context.read<ThemeCubit>().loadInformation();

    final userStorage = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    final user = await SecureStorageService.storage
        .read(key: SecureStorageService.userKey);

    final checkInfo = await SecureStorageService.storage
        .read(key: SecureStorageService.informationKey);

    //! Harus hilang BUAT CEK AJA
    // SecureStorageService.storage.deleteAll();
    print("TOken => $userStorage");
    print("User => $user");
    print("Check Splash => $checkInfo");

    //!

    if (userStorage != null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const String _imgUrl = 'http://103.100.27.29/sppd/public/storage/';

    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.informationModel.appInfo!,
                    style: txSemiBold.copyWith(
                      color: whiteColor,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   'Management',
                  //   style: txSemiBold.copyWith(
                  //     color: whiteColor,
                  //     fontSize: 32,
                  //   ),
                  // ),

                  Image.network(
                    _imgUrl + state.informationModel.logoMain!,
                    height: 250,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
