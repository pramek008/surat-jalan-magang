import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/bloc/auth_bloc.dart';
import 'package:surat_jalan/cubit/letter_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:surat_jalan/ui/widgets/card_letter_tile_widget.dart';

import '../../../models/user_model.dart';

class LetterDoneListTab extends StatefulWidget {
  const LetterDoneListTab({
    Key? key,
  }) : super(key: key);

  @override
  State<LetterDoneListTab> createState() => _LetterDoneListTabState();
}

class _LetterDoneListTabState extends State<LetterDoneListTab> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthLoadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colors = [
      const Color(0xff006EE9),
      const Color(0xff18DC4F),
      const Color(0xffE9A800),
      const Color(0xffDA4505),
      const Color(0xff9E20D9),
    ];

    return Scaffold(
      backgroundColor: backgrounColor,
      body: BlocConsumer<LetterCubit, LetterState>(
        listener: (context, state) {
          if (state is LetterError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state is LetterLoaded) {
            var lastday = DateTime.now().subtract(const Duration(days: 1));
            return SingleChildScrollView(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  UserModel? user = authState is AuthAuthenticatedState
                      ? authState.user
                      : null;
                  return Column(
                    //* logic penugasan yang SUDAH SELESAI dilakukan
                    children: state.letters
                        .where((element) => element.userId.id == user?.id)
                        .where((element) => element.tglAkhir.isBefore(lastday))
                        .map((e) => Container(
                              padding: e ==
                                      state.letters
                                          .where((element) =>
                                              element.userId.id == user?.id)
                                          .where((element) => element.tglAkhir
                                              .isBefore(lastday))
                                          .first
                                  ? EdgeInsets.only(top: defaultMargin)
                                  : const EdgeInsets.only(top: 0),
                              margin: e ==
                                      state.letters
                                          .where((element) =>
                                              element.userId.id == user?.id)
                                          .where((element) => element.tglAkhir
                                              .isBefore(lastday))
                                          .last
                                  ? EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                                  0.1 +
                                              15)
                                  : EdgeInsets.only(bottom: defaultMargin),
                              child: CardLetterTileWidget(
                                  color: (colors..shuffle()).first, surat: e),
                            ))
                        .toList(),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
