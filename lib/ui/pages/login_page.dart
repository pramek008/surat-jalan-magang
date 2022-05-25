import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/main_page.dart';
import 'package:surat_jalan/ui/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget heading() {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15),
        child: Text(
          'SPDD Management',
          style: txBold.copyWith(
            color: primaryColor,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget loginForm() {
      return Column(
        children: [
          Text(
            'Login to Your Account',
            style: txMedium.copyWith(
              color: greySubHeaderColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                size: 30,
                color: primaryColor,
              ),
              labelText: 'Email',
              labelStyle: txRegular.copyWith(
                color: greySubHeaderColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greyThinColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                size: 30,
                color: primaryColor,
              ),
              labelText: 'Password',
              labelStyle: txRegular.copyWith(
                color: greySubHeaderColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greyThinColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomePage()),
                //     (route) => false);
              },
              child: Text(
                'Login',
                style: txMedium.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum memiliki akun?',
            style: txRegular.copyWith(
              color: greyDeepColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Daftar',
            style: txBold.copyWith(
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading(),
                  const SizedBox(
                    height: 70,
                  ),
                  loginForm(),
                  const SizedBox(
                    height: 35,
                  ),
                  footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
