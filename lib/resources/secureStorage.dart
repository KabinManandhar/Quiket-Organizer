import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = new FlutterSecureStorage();

// class SecureStorage {
//   static int id;
//   static String token;

//   static getValues() async {
//     Map<String, String> values = await secureStorage.readAll();
//     String valueOfId = values['id'];
//     id = int.parse(valueOfId);
//     token = values['token'];
//   }

//   deleteValues() {
//     secureStorage.deleteAll();
//   }
// }
