import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/credentials/splash_screen.dart';
import 'package:testawwpp/Ui/events/create_event_screen.dart';
import 'package:testawwpp/Ui/tickets/create_ticket_screen.dart';

import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/credentials/login_screen.dart';
import 'package:testawwpp/Ui/credentials/register_screen.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';

const String homeRoute = '/home';
const String registerRoute = '/register';
const String loginRoute = '/login';
const String profileRoute = '/home/profile';
const String searchRoute = '/home/search';
const String splashRoute = "/";
const String menuRoute = '/home/menu';
const String createEventRoute = '/home/createEvent';
const String createTicketRoute = '/home/events/createTicket';

MaterialPageRoute routes(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => SplashScreenQuiket());
    case createEventRoute:
      return MaterialPageRoute(builder: (context) => CreateEvent());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case homeRoute:
      return MaterialPageRoute(builder: (context) {
        final bloc = GetEventBlocProvider.of(context);
        bloc.getIds();
        return HomeScreen();
      });
  }
  return null;
}
