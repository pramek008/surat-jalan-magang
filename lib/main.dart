import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surat_jalan/cubit/page_cubit.dart';
import 'package:surat_jalan/ui/main_page.dart';
import 'package:surat_jalan/ui/pages/login_page.dart';
import 'package:surat_jalan/ui/pages/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageCubit>(
          create: (context) => PageCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Pelaporan SPPD',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MainPage(),
        },
      ),
    );
  }
}
