import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/models/ticket_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class TicketApiProvider {
  final _evtUrl = '/events';
  final _tickUrl = '/tickets';
  final _orgUrl = '/organizers';
  String valueOfId;
  String token;
  int id;

  Future<List<int>> getTicketsIds(int id) async {
    try {
      final response = await req.getRequest(_evtUrl + "/$id" + _tickUrl);
      final ids = json.decode(response.body);
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TicketModel> getTicket(int id) async {
    try {
      final response = await req.getRequest(_tickUrl + '/$id');
      final ticket = json.decode(response.body);
      return TicketModel.fromJson(ticket);
    } catch (e) {
      print(e);
      return null;
    }
  }

  deleteTicket() {}

  createTicket(
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
    var response =
        await req.authPostRequest(data, _orgUrl + _evtUrl + _tickUrl, token);
    return response;
  }
}
