import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class TicketApiProvider {
  final _rootUrl = '/events';
  final _orgUrl = '/organizers';
  String valueOfId;
  String token;
  int id;

  Future<List<int>> getEventsId() async {
    try {
      valueOfId = await secureStorage.read(key: 'id');
      token = await secureStorage.read(key: 'token');
      id = int.parse(valueOfId);
      final response = await req.getRequest("/$id" + _rootUrl);
      final ids = json.decode(response.body);
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<EventModel> getTicket(int id) async {
    try {
      final response = await req.getRequest(_rootUrl + '/$id');
      final event = json.decode(response.body);
      return EventModel.fromJson(event);
    } catch (e) {
      print(e);
      return null;
    }
  }

  deleteEvent() {}

  createEvent(
      String name,
      String description,
      String category,
      String venue,
      String type,
      String startDateTime,
      String endDateTime,
      String picture) async {
    Map<String, String> data = {
      'name': name,
      'description': description,
      'category': category,
      'venue': venue,
      'type': type,
      'status': '0',
      'picture': picture,
      'start_datetime': startDateTime,
      'end_datetime': endDateTime,
      'organizer_id': id.toString(),
    };
    var response = await req.authPostRequest(data, _orgUrl + _rootUrl, token)(
        data, _orgUrl + _rootUrl);
    return response;
  }
}
