import 'dart:convert';
import 'requests.dart';
import "../models/event_model.dart";

class EventApiProvider {
  final fetchAllEvent = '/events';

  fetchEvent() {
    final response = req.getRequest(fetchAllEvent);
    final event = json.decode(response.body);
    return event;
  }

  createEvent(data) async {}
}
