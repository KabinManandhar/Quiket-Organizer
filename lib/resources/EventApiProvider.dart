import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class EventApiProvider {
  final _rootUrl = '/events';

  Future<List<int>> getEventsId() async {
    String value = await secureStorage.read(key: 'id');
    int id = int.parse(value);
    try {
      final response = await req.getRequest("/${6}" + _rootUrl);
      final ids = json.decode(response.body);
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<EventModel> getEvent(int id) async {
    try {
      final response = await req.getRequest(_rootUrl + '/$id');
      final event = json.decode(response.body);
      return EventModel.fromJson(event);
    } catch (e) {
      print(e);
      return null;
    }
  }

  createEvent(data) async {}
}
