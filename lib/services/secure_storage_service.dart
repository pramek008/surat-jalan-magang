import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const storage = FlutterSecureStorage();

  void read(String key) async {
    final value = await storage.read(key: key);
    print('$key => $value');
  }

  static const String tokenKey = 'token';
  static const String userKey = 'user';
  static const String informationKey = 'information';
}
