import 'dart:convert';

import 'package:http/http.dart';
import 'package:QuicketOrganizer/models/organizer_model.dart';
import 'package:QuicketOrganizer/resources/secureStorage.dart';
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

  update(String name, String password, String phoneNo, String description,
      String email, String picture, String token, int id) async {
    Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
      'phone_no': phoneNo,
      'description': description,
      'picture': picture
    };
    var response = await req.putRequest(data, _getProfile + '$id', token);
    return response;
  }

  Future<OrganizerModel> getProfile() async {
    try {
      String _valueOfId = await secureStorage.read(key: 'id');
      int _id = int.parse(_valueOfId);
      final response = await req.getRequest(_getProfile + '$_id');
      final organizer = json.decode(response.body);
      return OrganizerModel.fromJson(organizer);
    } catch (e) {
      return null;
    }
  }
}
