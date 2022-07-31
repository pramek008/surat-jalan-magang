import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/shared/shared_value.dart';

class LetterService {
  Future<List<LetterModel>> getAllLetter() async {
    // String _url = 'http://103.100.27.29/sppd/public/api/perintah-jalan';

    final String _url = "$baseApiURL/perintah-jalan";

    final response = await http.get(Uri.parse(_url));
    // print(response.statusCode);
    // print(jsonDecode(response.body));

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<LetterModel> allLeter = [];
        Map<String, dynamic> json = jsonDecode(response.body);
        print(json);

        json.forEach((key, value) {
          for (var i = 0; i < value.length; i++) {
            allLeter.add(LetterModel.fromJson(value[i]));
          }

          // allLeter.add(LetterModel.fromJson(value[0]));
          // print(allLeter);
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
