import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/helper_service.dart';
import 'package:surat_jalan/services/secure_storage_service.dart';

class AuthService {
  static String url = 'http://103.100.27.29/sppd/public/api/login';
  static String urlUser = 'http://103.100.27.29/sppd/public/api/user';
  static String urlLogout = 'http://103.100.27.29/sppd/public/api/logout';

  Future<UserModel> loadUser() async {
    final storage = await SecureStorageService.storage
        .read(key: SecureStorageService.userKey);
    if (storage != null) {
      return UserModel.fromJson(json.decode(storage));
    } else {
      throw Exception('User not found');
    }
  }

  static void saveUser(UserModel user) async {
    await SecureStorageService.storage.write(
      key: SecureStorageService.userKey,
      value: json.encode(user.toJson()),
    );
  }

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

  Future<UserModel> catchUser(int id) async {
    return http.get(Uri.parse(urlUser + '/$id')).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Map<String, dynamic> responseData = jsonResponse["data"];

        print("catch USER => $responseData");
        return UserModel.fromJson(responseData);
      } else {
        throw Exception('Failed to load user');
      }
    });
  }

  Future<ResponseModel> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "password": password,
      },
    );
    // print(response.body);

    final statusType = (response.statusCode / 100).floor() * 100;
    switch (statusType) {
      case 200:
        final json = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(json);
        // save token to secure storage
        saveToken(responseData.data!.token);
        catchUser(responseData.data!.user.id).then((user) {
          saveUser(user);
        });
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
    var token =
        SecureStorageService.storage.read(key: SecureStorageService.tokenKey);

    print("TOKEN => $token");
    final response = await http.post(
      Uri.parse(urlLogout),
      headers: HelperService.buildHeaders(accessToken: token.toString()),
    );
    SecureStorageService.storage.deleteAll();

    print(response.body);

    final statusType = (response.statusCode / 100).floor() * 100;
    switch (statusType) {
      case 200:
        SecureStorageService.storage.deleteAll();
        final json = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(json);

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

    // await SecureStorageService.storage.deleteAll();
  }

  // Future deleteUser() async {
  //   SecureStorageService.storage.delete(
  //     key: SecureStorageService.userKey,
  //   );
  // }
}
