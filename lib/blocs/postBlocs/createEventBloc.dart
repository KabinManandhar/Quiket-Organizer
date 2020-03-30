import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../validators.dart';

class CreateEventBloc extends Object with Validators {
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
  Stream<String> get venue => _venue.stream;
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
  Function(String) get changeVenue => _description.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changePicture => _picture.sink.add;
  Function(String) get changeCategory => _category.sink.add;
  Function(String) get changeType => _type.sink.add;
  Function(String) get changeStartDateTime => _startDateTime.sink.add;
  Function(String) get changeEndDateTime => _endDateTime.sink.add;

  submit() {
    final validPicture = _picture.value;
    final validName = _name.value;
    final validDescription = _description.value;
    final validCategory = _category.value;
    final validType = _type.value;
    final validStartDateTime = _startDateTime.value;
    final validEndDateTime = _endDateTime.value;

    print('Picture: $validPicture');
    print('Name: $validName');
    print('StartDateTime: $validStartDateTime');
    print('EndDateTime: $validEndDateTime');
    print('Type: $validType');
    print('Description: $validDescription');
    print('Category: $validCategory');
  }

  register() {}

  dispose() {
    _name.close();
    _venue.close();
    _description.close();
    _category.close();
    _picture.close();
    _type.close();
    _startDateTime.close();
    _endDateTime.close();
  }
}
