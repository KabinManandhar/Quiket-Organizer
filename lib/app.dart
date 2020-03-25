import 'package:flutter/material.dart';
import 'package:testawwpp/control/routes.dart';

import 'package:testawwpp/control/themedata.dart';

import 'blocs/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Quiket Organizers',
        theme: themedata(),
        onGenerateRoute: routes,
      ),
    );
  }
}
