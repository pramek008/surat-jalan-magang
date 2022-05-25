import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surat_jalan/cubit/page_cubit.dart';
import 'package:surat_jalan/shared/theme.dart';

class NavBarItemWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  final int index;

  const NavBarItemWidget(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.13,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgUrl,
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.height * 0.04,
              color: context.read<PageCubit>().state == index
                  ? primaryColor
                  : greyIconColor,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: txMedium.copyWith(
                fontSize: 12,
                color: context.read<PageCubit>().state == index
                    ? primaryColor
                    : greyIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
