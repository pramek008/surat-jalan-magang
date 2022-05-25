import 'package:flutter/material.dart';
import 'package:surat_jalan/shared/theme.dart';

class CardNewsWidget extends StatelessWidget {
  const CardNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://asset.kompas.com/crops/Efu-ShnT6peoIqLh8SyjTWKL9Zw=/0x0:728x486/780x390/filters:watermark(data/photo/2020/03/10/5e6775ae18c31.png,0,-0,1)/data/photo/2022/04/08/625039306042e.jpg',
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pemerintah Bakal Cabut Subsidi Minyak Goreng Curah 31 Mei 2022',
                  style: txSemiBold.copyWith(
                    color: blackColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Pemerintah bakal mencabut subsidi minyak goreng curah mulai 31 Mei 2022. Pemerintah pun',
                  style: txRegular.copyWith(
                    color: greyIconColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Kompas.com',
                    style: txSemiBold.copyWith(
                      color: blackColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
