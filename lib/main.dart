import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:surat_jalan/bloc/auth_bloc.dart';
import 'package:surat_jalan/bloc/login_bloc.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/cubit/location_cubit.dart';
import 'package:surat_jalan/cubit/news_cubit.dart';
import 'package:surat_jalan/cubit/page_cubit.dart';
import 'package:surat_jalan/ui/main_page.dart';
import 'package:surat_jalan/ui/pages/login_page.dart';
import 'package:surat_jalan/ui/pages/splash_screen.dart';

import 'cubit/report_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => LetterCubit(),
        ),
        BlocProvider(
          create: (context) => ReportCubit(),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
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
