import 'package:http/http.dart' as http;
import 'dart:convert';

class Requests {
  final _url = "http://192.168.100.64:8000/api"; //instantiate the root url
  postRequest(data, apiUrl) async {
    final fullUrl = _url + apiUrl;
    print('FullURL=' + fullUrl);
    final response = await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
    return response.body;
  }

  getRequest(apiUrl) async {
    final fullUrl = _url + apiUrl;
    final response = await http.get(fullUrl, headers: _setHeaders());
    return response;
  }

  _setAuthHeaders(String authToken) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authToken
      };
  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}

final req = Requests();
