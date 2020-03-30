import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/postBlocs/createEventBlocProvider.dart';
import 'package:testawwpp/control/routes.dart';

import 'package:testawwpp/control/themedata.dart';

import 'blocs/postBlocs/createTicketBlocProvider.dart';
import 'blocs/postBlocs/credentialBlocProvider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CreateTicketBlocProvider(
      child: CreateEventBlocProvider(
        child: CredentialBlocProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Quiket Organizers',
            theme: themedata(),
            onGenerateRoute: routes,
          ),
        ),
      ),
    );
  }
}
