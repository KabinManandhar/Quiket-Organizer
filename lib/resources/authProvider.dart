import 'dart:convert';

import 'package:http/http.dart';
import 'package:testawwpp/models/organizer_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';
import 'requests.dart';

class AuthProvider {
  Client client = Client();
  final _register = "/organizer/register";
  final _login = "/organizer/login";
  final _logout = "/organizer/logout/";
  final _getProfile = "/organizers/";

  login(String email, String password) async {
    Map<String, String> data = {'email': email, 'password': password};
    var response = await req.postRequest(data, _login);
    return response;
  }

  register(String name, String email, String password, String phoneNo) async {
    Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
      'phone_no': phoneNo
    };
    var response = await req.postRequest(data, _register);
    return response;
  }

  logout(id, token) async {
    var data;
    var response = await req.authPostRequest(data, _logout + '$id', token);
    return response;
  }

  Future<OrganizerModel> getProfile() async {
    try {
      String _valueOfId = await secureStorage.read(key: 'id');
      int _id = int.parse(_valueOfId);
      final response = await req.getRequest(_getProfile + '$_id');
      print(response.body);
      final organizer = json.decode(response.body);
      return OrganizerModel.fromJson(organizer);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
