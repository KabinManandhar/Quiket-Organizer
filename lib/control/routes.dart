import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/create_event_screen.dart';
import 'package:testawwpp/Ui/create_ticket_screen.dart';

import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/login_screen.dart';
import 'package:testawwpp/Ui/register_screen.dart';
import 'package:testawwpp/blocs/getBlocs/getEventBlocProvider.dart';

const String loginRoute = '/';
const String registerRoute = '/register';
const String homeRoute = '/home';
const String profileRoute = '/home/profile';
const String searchRoute = '/home/search';
const String menuRoute = '/home/menu';
const String createEventRoute = '/home/createEvent';
const String createTicketRoute = '/home/events/createTicket';

MaterialPageRoute routes(RouteSettings settings) {
  switch (settings.name) {
    case createEventRoute:
      return MaterialPageRoute(builder: (context) => CreateTicket());
    case loginRoute:
      return MaterialPageRoute(builder: (context) {
        final bloc = GetEventBlocProvider.of(context);
        bloc.getIds();
        return HomeScreen();
      });
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
