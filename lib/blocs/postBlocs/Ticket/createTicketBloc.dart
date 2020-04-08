import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import 'package:testawwpp/blocs/validators.dart';
import 'package:testawwpp/models/ticket_model.dart';
import 'package:testawwpp/resources/TicketApiProvider.dart';

class CreateTicketBloc extends Object with Validators {
  final _ticketProvider = TicketApiProvider();
  final _name = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _vStatus = BehaviorSubject<bool>();
  final _maxAllowed = BehaviorSubject<String>();
  final _minAllowed = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _type = BehaviorSubject<bool>();

  // Add data to stream
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<bool> get vStatus => _vStatus.stream;
  Stream<String> get maxAllowed =>
      _maxAllowed.stream.transform(validateNegativeValues);
  Stream<String> get minAllowed =>
      _minAllowed.stream.transform(validateNegativeValues);
  Stream<String> get description => _description.stream;
  Stream<String> get price => _price.stream.transform(validateNegativeValues);
  Stream<bool> get type => _type.stream;

  Stream<bool> get submitValid => Rx.combineLatest4(
      name, description, minAllowed, maxAllowed, (s, d, mi, mx) => true);

  Stream<bool> get editValid => name.map((name) => true);
  // Rx.combineLatest2(name, description, (s, d) => true);

  // Change data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changeMinAllowed => _minAllowed.sink.add;
  Function(String) get changeMaxAallowed => _maxAllowed.sink.add;
  Function(String) get changePrice => _price.sink.add;
  Function(bool) get changeStatus => _vStatus.sink.add;
  Function(bool) get changeType => _type.sink.add;

  submit(int eventId) async {
    var validMaxAllowed = _maxAllowed.value;
    final validName = _name.value;
    final validDescription = _description.value;
    var validMinAllowed = _minAllowed.value;
    var validPrice;
    if (_price.value == null) {
      validPrice = '0';
    } else {
      validPrice = _price.value;
    }
    if (validMaxAllowed == null || validMaxAllowed == '') {
      validMaxAllowed = '0';
    }
    if (validMinAllowed == null || validMinAllowed == '') {
      validMinAllowed = '0';
    }

    final validStatus = _vStatus.value;
    final validType = _type.value;

    var data = TicketModel(
            name: validName,
            description: validDescription,
            maxTicket: int.parse(validMaxAllowed),
            minTicket: int.parse(validMinAllowed),
            price: int.parse(validPrice),
            status: validStatus ? 0 : 1,
            ticketType: validType ? 0 : 1,
            eventId: eventId)
        .toJson();

    var _jsonResponse = await _ticketProvider.createTicket(data);
    var result = json.decode(_jsonResponse.body);

    removeValues();
  }

  edit(int ticketId, TicketModel ticketData) async {
    var validMaxAllowed = _maxAllowed.value;
    var validName = _name.value;
    var validDescription = _description.value;
    var validMinAllowed = _minAllowed.value;
    var validPrice = _price.value;
    var validStatus = _vStatus.value;
    var validType = _type.value;

    if (validName == '' || validName == null) {
      validName = ticketData.name;
    }
    if (validDescription == '' || validDescription == null) {
      validDescription = ticketData.description;
    }
    if (validMaxAllowed == null || validMaxAllowed == '') {
      validMaxAllowed = ticketData.maxTicket.toString();
    }
    if (validMinAllowed == null || validMinAllowed == '') {
      validMinAllowed = ticketData.minTicket.toString();
    }
    if (validStatus == null || validStatus == null) {
      validStatus = (ticketData.status) == 0 ? false : true;
    }
    if (validType == null || validType == null) {
      validType = (ticketData.ticketType) == 0 ? false : true;
    }
    if (validPrice == null || validPrice == '') {
      validPrice = ticketData.price.toString();
    }

    var data = TicketModel(
            id: ticketData.id,
            name: validName,
            description: validDescription,
            maxTicket: int.parse(validMaxAllowed),
            minTicket: int.parse(validMinAllowed),
            price: int.parse(validPrice),
            status: validStatus ? 0 : 1,
            ticketType: validType ? 0 : 1,
            eventId: ticketData.eventId)
        .toJson();

    var _jsonResponse = await _ticketProvider.editTicket(data, ticketId);
    var result = json.decode(_jsonResponse.body);

    removeValues();
  }

  removeValues() {
    _name.value = '';
    _description.value = '';
    _vStatus.value = null;
    _minAllowed.value = '';
    _price.value = '';
    _maxAllowed.value = '';
    _type.value = null;
  }

  dispose() {
    _name.drain();
    _name.close();
    _description.drain();
    _description.close();
    _vStatus.drain();
    _vStatus.close();
    _minAllowed.drain();
    _minAllowed.close();
    _price.drain();
    _price.close();
    _maxAllowed.drain();
    _maxAllowed.close();
    _type.drain();
    _type.close();
  }
}
// print('Name: $validName');
// print('Description: $validDescription');
// print('Ticket Type');
// print(validType);
// print('Min: $validMinAllowed');
// print('Max: $validMaxAllowed');
// print('Price: $validPrice');
// print('validStatus');
// print(validStatus);

// print('TicketData');
// print(ticketData.name);
// print(ticketData.description);
// print(ticketData.status);
// print(ticketData.ticketType);
// print(ticketData.maxTicket);
// print(ticketData.minTicket);
// print(ticketData.price);
// print('TicketData');
// print('Name: $validName');
// print('Description: $validDescription');
// print('validType');
// print(validType);
// print('Min: $validMinAllowed');
// print('Max: $validMaxAllowed');
// print('Price: $validPrice');
// print('validStatus');
// print(validStatus);
