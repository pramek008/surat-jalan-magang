import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:surat_jalan/models/report_model.dart';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/services/helper_service.dart';
import 'package:surat_jalan/services/secure_storage_service.dart';

class ReportService {
  final String _url = 'http://103.100.27.29/sppd/public/api/laporan-jalan';

  //! GET Request
  Future<List<ReportModel>> getAllReport() async {
    final response = await http.get(Uri.parse(_url));

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ReportModel> allReport = [];
        Map<String, dynamic> json = jsonDecode(response.body);

        json.forEach((key, value) {
          for (var i = 0; i < value.length; i++) {
            allReport.add(ReportModel.fromJson(value[i]));
          }
        });
        // print(allReport);
        return allReport;
      } else {
        throw Exception('Failed to load report');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //! POST Request
  Future postReport(int userId, int perintahJalanId, String namaKegiatan,
      List images, List lokasi, String deskripsi) async {
    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_url));

    //? HEADER
    request.headers['Authorization'] = 'Bearer ' + token.toString();

    //? BODY
    request.fields['user_id'] = userId.toString();
    request.fields['perintah_jalan_id'] = perintahJalanId.toString();
    request.fields['nama_kegiatan'] = namaKegiatan;

    //* Upload images
    List<http.MultipartFile> files = [];
    for (var i = 0; i < images.length; i++) {
      File image = File(images[i].toString());

      var stream = http.ByteStream(StreamView(image.openRead()));
      var length = await image.length();
      var filename = image.path.split('/').last;

      var multipartFile =
          http.MultipartFile('foto', stream, length, filename: filename);

      files.add(multipartFile);
    }
    request.files.addAll(files);
    //* END upload images

    //* Upload lokasi
    List<String> lokasiFiles = [];
    for (var i = 0; i < lokasi.length; i++) {
      lokasiFiles.add(lokasi[i].toString());
    }
    request.fields['lokasi'] = lokasiFiles.toString();
    //* END upload lokasi

    request.fields['deskripsi'] = deskripsi;
    //? END BODY

    //! Send request
    final response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //! PUT Request

  //! DELETE Request
  Future<ResponseModel> deleteReport(int id) async {
    // print('ID yang dibawa $id');

    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    final response = await http.delete(Uri.parse(_url + '/' + id.toString()),
        headers: HelperService.buildHeaders(accessToken: token));
    // print('DELETE Response ${response.statusCode}');
    // print(response.body);

    try {
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete report');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
