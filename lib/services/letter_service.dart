import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/letter_model.dart';
import 'package:surat_jalan/models/response_model.dart';
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

    var formData = FormData();
    formData.fields.addAll([
      MapEntry('user_id', userId.toString()),
      MapEntry('judul', judul),
      MapEntry('nomor_surat', nomorSurat),
      MapEntry('pemberi_perintah', pemberiPerintah),
      MapEntry('anggota_mengikuti', anggotaMengikuti.toString()),
      MapEntry('lokasi_tujuan', lokasiTujuan),
      MapEntry('keterangan', keterangan),
      MapEntry('tgl_awal', tglAwal.toString()),
      MapEntry('tgl_akhir', tglAkhir.toString()),
      MapEntry('diserahkan', diserahkan.toString()),
    ]);

    try {
      final response = await Dio().put(_url, data: formData);
      print(response.statusCode);
      print(response.data);

      final statusType = (response.statusCode! / 100).floor() * 100;
      switch (statusType) {
        case 200:
          Map<String, dynamic> json = (response.data);
          return ResponseModel(
            status: json["status"] as String,
            message: json["message"] as String,
          );
        case 400:
          Map<String, dynamic> json = (response.data);
          return ResponseModel(
            status: json["status"] as String,
            message: json["message"] as String,
          );
        case 300:
        case 500:
        default:
          Map<String, dynamic> json = (response.data);
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
