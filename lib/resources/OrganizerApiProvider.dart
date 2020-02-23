import 'dart:convert';
import 'package:http/http.dart' show Client;

class OrganizerApiProvider {
  Client client = Client();
  final _url = ""; //instantiate the root url

  fetchAllOrganizers() async {
    final response = await client.get('URL');
    final events = json.decode(response.body);

    return events;
  }

  fetchOrganizer(int id) async {
    final response = await client.get('URL');
    final event = json.decode(response.body);
    //return model.parsedJson
  }
}
