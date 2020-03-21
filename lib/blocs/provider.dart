import 'package:flutter/material.dart';
import 'credentialBloc.dart';

class Provider extends InheritedWidget {
  final credentialBloc = CredentialsBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CredentialsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        .credentialBloc;
  }
}
