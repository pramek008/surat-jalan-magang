import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/bloc/auth_bloc.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/shared/shared_theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthLoadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#########,##########');

    Widget heading() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 25,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Account',
              style: txSemiBold.copyWith(
                color: whiteColor,
                fontSize: 22,
              ),
            ),
            const Spacer(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icon_logout.png',
                        width: 30,
                        height: 30,
                      ),
                      Text(
                        'Logout',
                        style: txRegular.copyWith(
                          color: whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
    }

    Widget content(UserModel user) {
      Widget accountComponent(String title, String value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: txMedium.copyWith(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: value,
                hintStyle: txMedium.copyWith(
                  color: greyDeepColor,
                  fontSize: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: greyIconColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        );
      }

      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
          bottom: 50,
        ),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        child: Wrap(
          runSpacing: 20,
          children: [
            accountComponent('Nama', user.name),
            accountComponent('Username', user.username),
            accountComponent('E-Mail', user.email),
            accountComponent('NIP',
                formatter.format(int.parse(user.nip)).replaceAll(',', ' ')),
            accountComponent('Jabatan', user.jabatan),
          ],
        ),
      );
    }

    //! Master Widget Build
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultMargin,
              // right: defaultMargin,
              // left: defaultMargin,
            ),
            child: Column(
              children: [
                heading(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthAuthenticatedState) {
                      return content(state.user);
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
