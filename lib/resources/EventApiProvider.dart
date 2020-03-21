import 'dart:convert';
import 'package:http/http.dart' show Client;
import "../models/event_model.dart";

class EventApiProvider {
  Client client = Client();
  final _url = "http://127.0.0.1:8000/api"; //instantiate the root url
  final fetchAllEvent = '/events';

  // fetchAllEvents() async{
  //   final response= await client.get('URL');
  //   final events=json.decode(response.body);

  //   return events;
  // }

  fetchEvent() async {
    final response = await client.get(_url + fetchAllEvent);
    final event = json.decode(response.body);
    return event;
  }

  createEvent(data) async {}

  postRequest(data, apiUrl) async {
    final fullUrl = _url + apiUrl;
    final response = await client.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  _setAuthHeaders(String authToken) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authToken
      };
  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
}
