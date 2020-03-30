import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../validators.dart';

class CreateTicketBloc extends Object with Validators {
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

  Stream<bool> get submitValid =>
      Rx.combineLatest2(name, description, (s, d) => true);

  // Change data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changeMinAllowed => _minAllowed.sink.add;
  Function(String) get changeMaxAallowed => _maxAllowed.sink.add;
  Function(String) get changePrice => _price.sink.add;
  Function(bool) get changeStatus => _vStatus.sink.add;
  Function(bool) get changeType => _type.sink.add;

  submit() {
    final validMaxAllowed = _maxAllowed.value;
    final validName = _name.value;
    final validDescription = _description.value;
    final validMinAllowed = _minAllowed.value;
    final validPrice = _price.value;
    final validStatus = _vStatus.value;
    final validType = _type.value;

    print('Name: $validName');
    print('Description: $validDescription');
    print(validType);
    print('Min: $validMinAllowed');
    print('Max: $validMaxAllowed');
    print('Price: $validPrice');
    print(validStatus);
  }

  register() {}

  dispose() {
    _name.close();
    _description.close();
    _vStatus.close();
    _minAllowed.close();
    _price.close();
    _maxAllowed.close();
    _type.close();
  }
}
