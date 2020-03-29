import 'dart:convert';
import 'package:http/http.dart';
import 'requests.dart';

class AuthProvider {
  Client client = Client();
  final _register = "/organizer/register";
  final _login = "/organizer/login";

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
}

final auth = AuthProvider();
