import 'package:flutter/material.dart';
import 'package:surat_jalan/models/news_model.dart';
import 'package:surat_jalan/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CardNewsWidget extends StatelessWidget {
  final NewsModel news;
  const CardNewsWidget({Key? key, required this.news}) : super(key: key);

  void _launchUrl() async {
    if (!await launchUrl(
      Uri.parse(news.url),
      mode: LaunchMode.inAppWebView,
    )) throw 'Could not launch ${news.url}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchUrl();
      },
      child: Container(
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
                  news.urlToImage,
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
                    news.title,
                    style: txSemiBold.copyWith(
                      color: blackColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    news.description,
                    style: txRegular.copyWith(
                      color: greyIconColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      news.author,
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
      ),
    );
  }
}
