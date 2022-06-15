import 'dart:convert';

import '../models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<NewsModel>> getAllNews() async {
    String url = 'https://sppd-api.herokuapp.com/api/news';

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<NewsModel> allNews = [];
        List json = jsonDecode(response.body);

        for (var value in json) {
          allNews.add(NewsModel.fromJson(value));
        }

        // print(allNews);

        return allNews;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
