import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

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

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  register() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    final validName = _name.value;
    final validPhoneNo = _phoneNo.value;
    print('Email is $validEmail');
    print('Password is $validPassword');
    print('Email is $validName');
    print('Password is $validPhoneNo');
  }

  dispose() {
    _email.close();
    _password.close();
    _name.close();
    _phoneNo.close();
  }
}
