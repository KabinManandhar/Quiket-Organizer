import 'package:flutter/material.dart';
import 'package:testawwpp/routes.dart';

import 'package:testawwpp/themedata.dart';

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
