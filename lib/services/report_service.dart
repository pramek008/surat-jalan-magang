import "dart:async";
import "dart:convert";
// ignore: library_prefixes
import "package:dio/dio.dart" as Dio;
import "package:dio/dio.dart";
import 'package:flutter/widgets.dart';
import "package:surat_jalan/models/report_model.dart";
import "package:http/http.dart" as http;
import "package:surat_jalan/models/response_model.dart";
import "package:surat_jalan/services/helper_service.dart";
import "package:surat_jalan/services/secure_storage_service.dart";
import 'package:surat_jalan/shared/shared_value.dart';

class ReportService with ChangeNotifier {
  // final String _url = "http://103.100.27.29/sppd/public/api/laporan-jalan";

  final String _url = "$baseApiURL/laporan-jalan";

  //! GET Request
  Future<List<ReportModel>> getAllReport() async {
    final response = await http.get(Uri.parse(_url));

    try {
      if (response.statusCode == 200) {
        List<ReportModel> allReport = [];
        Map<String, dynamic> json = jsonDecode(response.body);
        List data = json["data"];

        for (var i = 0; i < data.length; i++) {
          allReport.add(ReportModel.fromJson(data[i]));
        }

        return allReport;
      } else {
        throw Exception("Failed to load report");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //! POST Request
  Future<ResponseModel> postReport(
      {required int userId,
      required int perintahJalanId,
      required String namaKegiatan,
      required List images,
      required List lokasi,
      required String deskripsi}) async {
    //*CEK data

    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    //! DIO ==============================================
    var formData = FormData();
    for (var img in images) {
      formData.files.addAll([
        MapEntry(
            "foto[]",
            await Dio.MultipartFile.fromFile(img.path,
                filename: img.path.split("/").last))
      ]);
    }

    for (var koor in lokasi) {
      formData.fields.add(MapEntry("lokasi[]", koor));
    }

    formData.fields.addAll([
      MapEntry("user_id", userId.toString()),
      MapEntry("perintah_jalan_id", perintahJalanId.toString()),
      MapEntry("nama_kegiatan", namaKegiatan),
      MapEntry("deskripsi", deskripsi)
    ]);

    print("=====FIELD: ${formData.fields}");
    // print("=====FILES: ${formData.files}");
    try {
      Dio.Response response = await Dio.Dio().postUri(Uri.parse(_url),
          data: formData, onSendProgress: (int sent, int total) {
        // print("=====PROGRESS: $sent / $total");
      },
          options: Options(
            headers: {
              "content-type": "application/json",
              "Authorization": "Bearer $token",
            },
            followRedirects: true,
            // will not throw errors
            validateStatus: (status) => true,
            method: "POST",
          ));

      print(response.statusCode);
      print('RESPONSE ${response.data}');

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

  //! PUT Request

  //! DELETE Request
  Future<ResponseModel> deleteReport(int id) async {
    print("ID yang dibawa $id");

    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    try {
      final response = await http.delete(Uri.parse(_url + "/" + id.toString()),
          headers: HelperService.buildHeaders(accessToken: token));
      print("DELETE Response ${response.statusCode}");
      print(response.body);
      final statusType = (response.statusCode / 100).floor() * 100;
      switch (statusType) {
        case 200:
          Map<String, dynamic> json = jsonDecode(response.body);
          notifyListeners();
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
