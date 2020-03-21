import 'package:flutter/material.dart';
import 'package:testawwpp/style.dart';

ThemeData themedata() {
  return ThemeData(
      cursorColor: Colors.black45,
      scaffoldBackgroundColor: Colors.grey[300],
      primaryColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(title: AppBarText),
      ),
      textTheme: TextTheme(title: TitleText, body1: Body1Text),
      brightness: Brightness.light,
      accentColor: Colors.black);
}
