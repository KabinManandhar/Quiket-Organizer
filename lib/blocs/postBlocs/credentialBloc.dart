import 'dart:async';
import 'dart:convert';
import 'package:testawwpp/resources/secureStorage.dart';

import '../validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testawwpp/resources/authProvider.dart';

class CredentialsBloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get phoneNo => _phoneNo.stream.transform(validatePhoneNo);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);
  Stream<bool> get registerValid =>
      Rx.combineLatest4(email, password, name, phoneNo, (e, p, n, ph) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changePhoneNo => _phoneNo.sink.add;

  login() async {
    String validEmail = _email.value;
    String validPassword = _password.value;
    var jsonResponse = await auth.login(validEmail, validPassword);
    var results = json.decode(jsonResponse);

    if (results['success']) {
      secureStorage.deleteAll();
      secureStorage.write(key: 'id', value: results['id'].toString());
      secureStorage.write(key: 'token', value: results['token']);
      return true;
    }
    print('Falsiewoer');
    return false;
  }

  register() async {
    final validEmail = _email.value;
    final validPassword = _password.value;
    final validName = _name.value;
    final validPhoneNo = _phoneNo.value;

    var jsonResponse =
        await auth.register(validName, validEmail, validPassword, validPhoneNo);
    var results = json.decode(jsonResponse);
    print(results);
    if (results['success']) {
      secureStorage.deleteAll();
      secureStorage.write(key: 'id', value: results['id'].toString());
      secureStorage.write(key: 'token', value: results['token']);
      return true;
    }
    return false;
  }

  dispose() {
    _email.close();
    _password.close();
    _name.close();
    _phoneNo.close();
  }
}
