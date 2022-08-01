import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/shared/shared_value.dart';

class LetterService {
  Future<List<LetterModel>> getAllLetter() async {
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

  Future<ResponseModel> putLetter({
    required int id,
    required int userId,
    required String judul,
    required String nomorSurat,
    required String pemberiPerintah,
    required List<String> anggotaMengikuti,
    required String lokasiTujuan,
    required String keterangan,
    required DateTime tglAwal,
    required DateTime tglAkhir,
    required bool diserahkan,
  }) async {
    String _url = '$baseApiURL/perintah-jalan/$id';

    try {
      var response = await http.put(
        Uri.parse(_url),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode({
          "user_id": userId,
          "judul": judul,
          "nomor_surat": nomorSurat,
          "pemberi_perintah": pemberiPerintah,
          "anggota_mengikuti": anggotaMengikuti,
          "lokasi_tujuan": lokasiTujuan,
          "keterangan": keterangan,
          "tgl_awal": tglAwal.toString(),
          "tgl_akhir": tglAkhir.toString(),
          "diserahkan": diserahkan,
        }),
      );
      print(response.statusCode);
      print(response.body);

      final statusType = (response.statusCode / 100).floor() * 100;
      switch (statusType) {
        case 200:
          Map<String, dynamic> json = jsonDecode(response.body);
          return ResponseModel(
            status: json["status"] as String,
            message: json["message"] as String,
          );
        case 400:
          Map<String, dynamic> json = jsonDecode(response.body);
          return ResponseModel(
            status: json["status"] as String,
            message: json["message"] as String,
          );
        case 300:
        case 500:
        default:
          Map<String, dynamic> json = jsonDecode(response.body);
          return ResponseModel(
            status: json["status"] as String,
            message: json["message"] as String,
          );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
