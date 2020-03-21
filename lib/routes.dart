import 'package:flutter/material.dart';

import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/login_screen.dart';
import 'package:testawwpp/Ui/register_screen.dart';

const String loginRoute = '/';
const String registerRoute = '/register';
const String homeRoute = '/home';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case homeRoute:
      return MaterialPageRoute(
          builder: (context) => HomeScreen(title: "Events"));
  }
}
