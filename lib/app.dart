import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/createEventBlocProvider.dart';
import 'package:testawwpp/control/routes.dart';

import 'package:testawwpp/control/themedata.dart';

import 'blocs/credentialBlocProvider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CreateEventBlocProvider(
      child: CredentialBlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quiket Organizers',
          theme: themedata(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }
}
