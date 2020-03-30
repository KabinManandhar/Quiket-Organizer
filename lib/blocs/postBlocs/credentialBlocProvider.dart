import 'package:flutter/material.dart';
import 'credentialBloc.dart';

class CredentialBlocProvider extends InheritedWidget {
  final credentialBloc = CredentialsBloc();

  CredentialBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CredentialsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CredentialBlocProvider>()
        .credentialBloc;
  }
}
