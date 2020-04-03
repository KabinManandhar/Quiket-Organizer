import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class EventApiProvider {
  final _rootUrl = '/events';
  final _orgUrl = '/organizers';
  String _valueOfId;
  String _token;
  int _id;

  Future<List<int>> getEventsId() async {
    try {
      _valueOfId = await secureStorage.read(key: 'id');
      _token = await secureStorage.read(key: 'token');
      _id = int.parse(_valueOfId);

      final response = await req.getRequest("/$_id" + _rootUrl);
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

  deleteEvent() {}

  createEvent(
      String name,
      String description,
      String category,
      String venue,
      String type,
      String status,
      String picture,
      String startDateTime,
      String endDateTime) async {
    _valueOfId = await secureStorage.read(key: 'id');
    _token = await secureStorage.read(key: 'token');
    _id = int.parse(_valueOfId);
    print(_id);
    Map<String, dynamic> data = EventModel(
            picture: picture,
            category: category,
            name: name,
            status: 0,
            description: description,
            venue: venue,
            type: type,
            organizerId: _id,
            startDatetime: startDateTime,
            endDatetime: endDateTime)
        .toMap();
    // Map<String, String> data = {
    //   'name': 'name',
    //   'description': 'description',
    //   'category': 'category',
    //   'venue': 'venue',
    //   'type': 'type',
    //   'status': '0',
    //   'picture': 'picture',
    //   'start_datetime': startDateTime,
    //   'end_datetime': endDateTime,
    //   'organizer_id': '6',
    // };

    print("Eventmodel data");
    print(data);
    var response = await req.authPostRequest(data, _orgUrl + _rootUrl, _token);
    return response;
  }
}
//  String name,
//       String description,
//       String category,
//       String venue,
//       String type,
//       String startDateTime,
//       String endDateTime,
//       String picture
