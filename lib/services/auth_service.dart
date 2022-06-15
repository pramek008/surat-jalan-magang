import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/services/secure_storage_service.dart';

class AuthService {
  static String url = 'http://sppd-api.herokuapp.com/api/login';

  static void saveToken(String? token) async {
    await SecureStorageService.storage.write(
      key: SecureStorageService.tokenKey,
      value: token,
    );
  }

  static void deleteToken() async {
    Timer(const Duration(minutes: 120), () {
      SecureStorageService.storage.delete(
        key: SecureStorageService.tokenKey,
      );
    });
  }

  Future<ResponseModel> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );

    final statusType = (response.statusCode / 100).floor() * 100;
    switch (statusType) {
      case 200:
        final json = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(json);

        // save token to secure storage
        saveToken(responseData.data!.token);
        deleteToken();

        return responseData;
      case 400:
        final json = jsonDecode(response.body);
        String message = json['message'];
        return ResponseModel(
          status: '400',
          message: message,
        );
      case 300:
      case 500:
      default:
        return ResponseModel(
          status: '500',
          message: 'Something went wrong',
        );
    }
  }

  Future logout() async {
    await SecureStorageService.storage.delete(
      key: SecureStorageService.tokenKey,
    );
  }
}
