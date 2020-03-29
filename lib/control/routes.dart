import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/create_event_screen.dart';
import 'package:testawwpp/Ui/create_ticket_screen.dart';

import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/login_screen.dart';
import 'package:testawwpp/Ui/register_screen.dart';

const String loginRoute = '/';
const String registerRoute = '/register';
const String homeRoute = '/home';
const String createRoute = '/home/create';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case createRoute:
      return MaterialPageRoute(builder: (context) => CreateTicket());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
