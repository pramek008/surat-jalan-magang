import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surat_jalan/models/response_model.dart';
import 'package:surat_jalan/models/user_model.dart';
import 'package:surat_jalan/services/helper_service.dart';
import 'package:surat_jalan/services/secure_storage_service.dart';
import 'package:surat_jalan/shared/shared_value.dart';

class AuthService {
  // static const String _url = 'http://103.100.27.29/sppd/public/api/login';
  // static const String _urlUser = 'http://103.100.27.29/sppd/public/api/user';
  // static const String _urlLogout =
  //     'http://103.100.27.29/sppd/public/api/logout';

  static final String _url = "$baseApiURL/login";
  static final String _urlUser = "$baseApiURL/user";
  static final String _urlLogout = "$baseApiURL/logout";

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

  Future<void> deleteToken() async {
    Duration duration = const Duration(minutes: 120);

    Future.delayed(duration)
        .then((value) => {SecureStorageService.storage.deleteAll()});
    // Timer(const Duration(minutes: 120), () async {
    //   SecureStorageService.storage.deleteAll();
    // });
  }

  Future<UserModel> catchUser(int id) async {
    return http.get(Uri.parse(_urlUser + '/$id')).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Map<String, dynamic> responseData = jsonResponse["data"];

        return UserModel.fromJson(responseData);
      } else {
        throw Exception('Failed to load user');
      }
    });
  }

  Future<ResponseModel> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(_url),
      body: {
        "email": email,
        "password": password,
      },
    );
    print("response login => ${response.body}");

    final statusType = (response.statusCode / 100).floor() * 100;
    switch (statusType) {
      case 200:
        final json = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(json);
        // save token to secure storage
        saveToken(responseData.data!.token);
        catchUser(responseData.data!.user!.id).then((user) {
          saveUser(user);
        });

        //* delete token sesuai dengan masa berlaku token berakhir
        deleteToken();

        return responseData;
      case 400:
        final json = jsonDecode(response.body);
        return ResponseModel(
          status: json['status'],
          message: json['message'],
        );
      case 300:
      case 500:
      default:
        final json = jsonDecode(response.body);
        return ResponseModel(
          status: json['status'],
          message: json['message'],
        );
    }
  }

  Future logout() async {
    final token = await SecureStorageService.storage
        .read(key: SecureStorageService.tokenKey);

    final response = await http.post(
      Uri.parse(_urlLogout),
      headers: HelperService.buildHeaders(accessToken: token),
    );
    SecureStorageService.storage.deleteAll();

    // print("response logout = > ${response.body}");

    final statusType = (response.statusCode / 100).floor() * 100;
    switch (statusType) {
      case 200:
        SecureStorageService.storage.deleteAll();
        final json = jsonDecode(response.body);
        final responseData = ResponseModel.fromJson(json);

        return responseData;
      case 400:
        final json = jsonDecode(response.body);
        return ResponseModel(
          status: json['status'],
          message: json['message'],
        );
      case 300:
      case 500:
      default:
        final json = jsonDecode(response.body);
        return ResponseModel(
          status: json['status'],
          message: json['message'],
        );
    }
  }
}
