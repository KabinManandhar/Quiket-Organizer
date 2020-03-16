import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/login_screen.dart';
import 'package:testawwpp/style.dart';
import 'Ui/register_screen.dart';
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
          theme: ThemeData(
              cursorColor: Colors.black45,
              scaffoldBackgroundColor: Colors.grey[300],
              primaryColor: Colors.grey[300],
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(title: AppBarText),
              ),
              textTheme: TextTheme(title: TitleText, body1: Body1Text),
              brightness: Brightness.light,
              accentColor: Colors.black),
          home: RegisterScreen() //HomeScreen(
          //   title: "Events",
          // ),
          ),
    );
  }
}
