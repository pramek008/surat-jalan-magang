import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/letter_model.dart';

class LetterService {
  Future<List<LetterModel>> getAllLetter() async {
    String url = 'https://sppd-api.herokuapp.com/api/perintah-jalan';

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    // print(jsonDecode(response.body));

    // if (response.statusCode == 200) {
    //   List<LetterModel> letters = [];
    //   List<dynamic> json = jsonDecode(response.body);
    //   json.forEach((letter) {
    //     letters.add(LetterModel.fromJson(letter));
    //   });
    //   return letters;
    // } else {
    //   throw Exception('Failed to load letter');
    // }

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<LetterModel> allLeter = [];
        Map<String, dynamic> json = jsonDecode(response.body);

        json.forEach((key, value) {
          print(value);

          allLeter.add(LetterModel.fromJson(value));
          // allLeter.add(jsonDecode(jsonDecode(value)));
        });

        return allLeter;
      } else {
        throw Exception('Failed to load letter');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
