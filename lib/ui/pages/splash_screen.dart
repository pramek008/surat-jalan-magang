import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    });
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
