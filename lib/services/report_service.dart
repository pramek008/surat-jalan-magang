import "dart:async";
import "dart:convert";
import "package:dio/dio.dart" as Dio;
import "package:dio/dio.dart";
import "package:surat_jalan/models/report_model.dart";
import "package:http/http.dart" as http;
import "package:surat_jalan/models/response_model.dart";
import "package:surat_jalan/services/helper_service.dart";
import "package:surat_jalan/services/secure_storage_service.dart";

class ReportService {
  final String _url = "http://103.100.27.29/sppd/public/api/laporan-jalan";

  //! GET Request
  Future<List<ReportModel>> getAllReport() async {
    final response = await http.get(Uri.parse(_url));

    try {
      if (response.statusCode == 200) {
        List<ReportModel> allReport = [];
        Map<String, dynamic> json = jsonDecode(response.body);
        List data = json["data"];
        print(data);

        for (var i = 0; i < data.length; i++) {
          allReport.add(ReportModel.fromJson(data[i]));
        }

        print("allReport: ${allReport.length}");
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
    // print(userId);
    // print(perintahJalanId);
    // print(namaKegiatan);
    // print(images);
    // print(lokasi);
    // print(deskripsi);

    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    // http.MultipartRequest request =
    //     http.MultipartRequest("POST", Uri.parse(_url));

    // //* Upload images
    // List<http.MultipartFile> files = [];
    // for (int i = 0; i < images.length; i++) {
    //   File image = File(images[i].path.toString());

    //   var stream = http.ByteStream(StreamView(image.openRead()));
    //   var length = await image.length();
    //   var filename = image.path.split("/").last;
    //   print(filename);

    //   var multipartFile =
    //       http.MultipartFile("foto", stream, length, filename: filename);
    //   var multiFile = await http.MultipartFile.fromPath('foto', image.path,
    //       filename: filename);

    //   files.add(multipartFile);
    // }
    // request.files.addAll(files);
    // //* END upload images

    // //* Upload lokasi
    // List<String> lokasiFiles = [];
    // for (var i = 0; i < lokasi.length; i++) {
    //   lokasiFiles.add(lokasi[i].toString());
    // }

    // var hearders = {
    //   "Content-Type": "multipart/form-data",
    //   "Authorization": "Bearer $token",
    // };

    // var body = {
    //   "user_id": userId,
    //   "perintah_jalan_id": perintahJalanId,
    //   "nama_kegiatan": namaKegiatan,
    //   "foto": files.toString(),
    //   "lokasi": lokasi.toString(),
    //   "deskripsi": deskripsi,
    // };

    // request.headers.addAll(hearders);
    // request.fields.addEntries(
    //     body.entries.map((e) => MapEntry(e.key, e.value.toString())));
    // // print(request.fields);
    // //! Send request
    // try {
    //   var response = await request.send();

    //   print(response.statusCode);
    //   print(response.persistentConnection);
    //   print(response.reasonPhrase);
    //   print(response.headers);

    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     response.stream.transform(utf8.decoder).listen((value) {
    //       print(value);
    //     });
    //     return response.statusCode.toString();
    //   } else {
    //     throw Exception("Failed to post report");
    //   }
    // } catch (e) {
    //   throw Exception(e.toString());
    // }

    // var response = await request.send();
    // print(response.statusCode);
    // print(response.reasonPhrase);
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });

    //! DIO ==============================================

    var formData = FormData();
    for (var img in images) {
      formData.files.addAll([
        MapEntry(
            "foto[]",
            await Dio.MultipartFile.fromFile(img.path,
                filename: img.path.split("/").last))
      ]);

      print("img.path: ${img.path}");
      print("imgNAME: ${img.path.split("/").last}");
    }
    formData.fields.addAll([
      MapEntry("user_id", userId.toString()),
      MapEntry("perintah_jalan_id", perintahJalanId.toString()),
      MapEntry("nama_kegiatan", namaKegiatan),
      // MapEntry("foto", img.path.split("/").last),
      MapEntry("lokasi[0]", lokasi[0]),
      MapEntry("lokasi[1]", lokasi[1]),
      MapEntry("deskripsi", deskripsi)
    ]);

    // Dio.FormData formData = Dio.FormData.fromMap({
    //   "user_id": userId.toString(),
    //   "perintah_jalan_id": perintahJalanId.toString(),
    //   "nama_kegiatan": namaKegiatan,
    //   "foto": arrImage,
    //   "lokasi": lokasi.toString(),
    //   "deskripsi": deskripsi,
    // });
    print("=====FIELD: ${formData.fields}");
    print("=====FILES: ${formData.files}");
    try {
      Dio.Response response = await Dio.Dio().postUri(Uri.parse(_url),
          data: formData,
          options: Options(
            headers: {
              "content-type": "application/json",
              // "Authorization": "Bearer $token",
            },
            followRedirects: true,
            // will not throw errors
            validateStatus: (status) => true,
            method: "POST",
          ));

      print(response.statusCode);
      print('RESPONSE ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Map<String, dynamic> json = jsonDecode(response.data);
        print('ini json =>${response.data}');
        return response.data;
      } else {
        return response.data;
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

    final response = await http.delete(Uri.parse(_url + "/" + id.toString()),
        headers: HelperService.buildHeaders(accessToken: token));
    print("DELETE Response ${response.statusCode}");
    print(response.body);

    try {
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to delete report");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
