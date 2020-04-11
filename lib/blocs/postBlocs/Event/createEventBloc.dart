import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../../../models/event_model.dart';
import '../../../resources/EventApiProvider.dart';
import '../../validators.dart';

class CreateEventBloc extends Object with Validators {
  final _eventProvider = EventApiProvider();
  final _name = BehaviorSubject<String>();
  final _venue = BehaviorSubject<String>();
  final _picture = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _category = BehaviorSubject<String>();
  final _type = BehaviorSubject<String>();
  final _startDateTime = BehaviorSubject<String>();
  final _endDateTime = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get venue => _venue.stream.transform(validateName);
  Stream<String> get picture => _picture.stream;
  Stream<String> get description => _description.stream;
  Stream<String> get category => _category.stream;
  Stream<String> get type => _type.stream;
  Stream<String> get startDateTime => _startDateTime.stream;
  Stream<String> get endDateTime => _endDateTime.stream;
  Stream<bool> get submitValid =>
      Rx.combineLatest2(name, description, (n, d) => true);

  // Change data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeVenue => _venue.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changePicture => _picture.sink.add;
  Function(String) get changeCategory => _category.sink.add;
  Function(String) get changeType => _type.sink.add;
  Function(String) get changeStartDateTime => _startDateTime.sink.add;
  Function(String) get changeEndDateTime => _endDateTime.sink.add;

  submit() async {
    final validPicture = _picture.value;
    final validName = _name.value;
    final validDescription = _description.value;
    final validCategory = _category.value;
    final validVenue = _venue.value;
    final validType = _type.value;
    final validStartDateTime = _startDateTime.value;
    final validEndDateTime = _endDateTime.value;

    print('DATA');
    print(validPicture);
    print(validName);
    print(validDescription);
    print(validCategory);
    print(validVenue);
    print(validType);
    print(validStartDateTime);
    print(validEndDateTime);
    print('DATA');

    // Map<String, dynamic> data = EventModel(
    //         picture: validPicture,
    //         category: validCategory,
    //         name: validName,
    //         status: 0,
    //         description: validDescription,
    //         venue: validVenue,
    //         type: validType,
    //         startDatetime: validStartDateTime,
    //         endDatetime: validEndDateTime)
    //     .toMap();

    var jsonResponse = await _eventProvider.createEvent(
        validName,
        validDescription,
        validCategory,
        validVenue,
        validType,
        validPicture,
        validStartDateTime,
        validEndDateTime);
    var result = json.decode(jsonResponse);
    print('Results');
    print(result['success']);
  }

  edit(int eventId, EventModel eventData) async {
    var validPicture = _picture.value;
    var validName = _name.value;
    var validDescription = _description.value;
    var validCategory = _category.value;
    var validVenue = _venue.value;
    var validType = _type.value;
    var validStartDateTime = _startDateTime.value;
    var validEndDateTime = _endDateTime.value;

    if (validName == '' || validName == null) {
      validName = eventData.name;
    }
    if (validDescription == '' || validDescription == null) {
      validDescription = eventData.description;
    }
    if (validCategory == null || validCategory == '') {
      validCategory = eventData.category;
    }
    if (validVenue == null || validVenue == '') {
      validVenue = eventData.venue;
    }

    if (validType == null || validType == '') {
      validType = eventData.type;
    }
    if (validStartDateTime == null || validStartDateTime == '') {
      validStartDateTime = eventData.startDatetime;
    }
    if (validEndDateTime == null || validEndDateTime == '') {
      validEndDateTime = eventData.endDatetime;
    }

    print('DATA');
    print(validPicture);
    print(validName);
    print(validDescription);
    print(validCategory);
    print(validVenue);
    print(validType);
    print(validStartDateTime);
    print(validEndDateTime);
    print('DATA');

    var jsonResponse = await _eventProvider.editEvent(
        eventData.id,
        validName,
        validDescription,
        validCategory,
        validVenue,
        validType,
        validPicture,
        validStartDateTime,
        validEndDateTime,
        eventId);
    var result = json.decode(jsonResponse);
    print('Results');
    print(result['success']);
  }

  delete(eventId) {}

  removeValues() {
    _name.value = '';
    _description.value = '';
    _category.value = '';
    //_picture.value = '';
    _type.value = '';
    _startDateTime.value = '';
    _endDateTime.value = '';
  }

  dispose() {
    _name.drain();
    _name.close();
    _venue.drain();
    _venue.close();
    _description.drain();
    _description.close();
    _category.drain();
    _category.close();
    _picture.drain();
    _picture.close();
    _type.drain();
    _type.close();
    _startDateTime.drain();
    _startDateTime.close();
    _endDateTime.drain();
    _endDateTime.close();
  }
}
