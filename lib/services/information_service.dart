import 'dart:convert';

import 'package:surat_jalan/models/information_model.dart';
import 'package:http/http.dart' as http;
import 'package:surat_jalan/services/secure_storage_service.dart';

class InformationService {
  final String _url = 'http://103.100.27.29/sppd/public/api/information';

  static void saveInformation(InformationModel information) async {
    await SecureStorageService.storage.delete(
      key: SecureStorageService.informationKey,
    );
    await SecureStorageService.storage.write(
      key: SecureStorageService.informationKey,
      value: json.encode(information.toJson()),
    );

    final checkInfo = await SecureStorageService.storage
        .read(key: SecureStorageService.informationKey);

    print(checkInfo);
  }

  // Future<void> deleteInformation() async {
  //   await SecureStorageService.storage
  //       .delete(key: SecureStorageService.informationKey);
  // }

  Future<InformationModel> getInformation() async {
    return await http.get(Uri.parse(_url)).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<InformationModel> information = [];

        responseData.forEach((key, value) {
          for (var i = 0; i < value.length; i++) {
            information.add(InformationModel.fromJson(value[i]));
          }
        });

        saveInformation(information.last);

        //! must deleted on production
        // getInformationFromStorage();
        //!

        return information.last;
      } else {
        throw Exception('Failed to get information data');
      }
    });
  }

  Future<InformationModel> getInformationFromStorage() async {
    final storage = await SecureStorageService.storage
        .read(key: SecureStorageService.informationKey);

    if (storage != null) {
      // print("storageeeeeee => $storage");
      return InformationModel.fromJson(json.decode(storage));
    } else {
      throw Exception('Information not found');
    }
  }
}
