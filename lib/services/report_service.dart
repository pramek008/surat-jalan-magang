import 'dart:convert';

import 'package:surat_jalan/models/report_model.dart';
import 'package:http/http.dart' as http;

class ReportService {
  Future<List<ReportModel>> getAllReport() async {
    String url = 'http://103.100.27.29/sppd/public/api/laporan-jalan';

    final response = await http.get(Uri.parse(url));

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
}
