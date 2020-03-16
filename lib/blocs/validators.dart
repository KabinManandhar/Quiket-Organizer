import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 5 characters');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 1) {
      sink.add(name);
    } else {
      sink.addError('Please enter your Name.');
    }
  });

  final validatePhoneNo = StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNo, sink) {
    if (phoneNo.length >= 10) {
      sink.add(phoneNo);
    } else {
      sink.addError('Please enter your Phone No.');
    }
  });
}
