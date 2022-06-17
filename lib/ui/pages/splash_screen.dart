import 'dart:async';

import 'package:flutter/material.dart';
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
    super.initState();
    _remindUser();
  }

  Future<void> _remindUser() async {
    final storage = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    final user = await SecureStorageService.storage
        .read(key: SecureStorageService.userKey);

    //! Harus hilang BUAT CEK AJA
    // SecureStorageService.storage.deleteAll();
    print("TOken => $storage");
    print("User => $user");

    //!

    if (storage != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPPD',
              style: txSemiBold.copyWith(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
            Text(
              'Management',
              style: txSemiBold.copyWith(
                color: whiteColor,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
