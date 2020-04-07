import 'package:flutter/material.dart';
import 'package:testawwpp/Ui/Order/order_screen.dart';
import 'package:testawwpp/Ui/credentials/splash_screen.dart';
import 'package:testawwpp/Ui/events/create_event_screen.dart';
import 'package:testawwpp/Ui/screens/dashboard.dart';
import 'package:testawwpp/Ui/screens/menu.dart';
import 'package:testawwpp/Ui/screens/scanner.dart';
import 'package:testawwpp/Ui/navigation_screen.dart';
import 'package:testawwpp/Ui/tickets/create_ticket_screen.dart';
import 'package:testawwpp/Ui/tickets/edit_ticket.dart';
import 'package:testawwpp/Ui/tickets/ticket_screen.dart';

import 'package:testawwpp/Ui/home_screen.dart';
import 'package:testawwpp/Ui/credentials/login_screen.dart';
import 'package:testawwpp/Ui/credentials/register_screen.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';

const String homeRoute = '/home';
const String registerRoute = '/register';
const String loginRoute = '/login';
const String profileRoute = '/home/profile';
const String searchRoute = '/home/search';
const String orderRoute = '/home/order';
const String ticketRoute = '/home/ticket';
const String scannerRoute = '/home/scanner';
const String dashboardRoute = '/home/dashboard';

const String splashRoute = "/";
const String menuRoute = '/home/menu';
const String createEventRoute = '/home/createEvent';
const String createTicketRoute = '/home/createTicket';

MaterialPageRoute routes(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => SplashScreenQuiket());
      break;
    case loginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
      break;
    case registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
      break;
    case homeRoute:
      return MaterialPageRoute(builder: (context) {
        final bloc = GetEventBlocProvider.of(context);
        bloc.getIds();
        return HomeScreen();
      });
      break;
    case createEventRoute:
      return MaterialPageRoute(builder: (context) => CreateEvent());
      break;
    case createTicketRoute:
      return MaterialPageRoute(builder: (context) => CreateTicket());
      break;
    default:
      return MaterialPageRoute(
        builder: (context) {
          final routing = settings.name;
          //Nav Screen
          if (routing.startsWith('/navigation/')) {
            var value = routing.replaceFirst('/navigation/', '');
            int eventId = int.parse(value);
            return NavigationScreen(eventId: eventId);
          }
          //Ticket Screen
          else if (routing.startsWith('/ticket/')) {
            var value = routing.replaceFirst('/ticket/', '');
            int eventId = int.parse(value);
            return TicketScreen(eventId: eventId);
          }
          //Order
          else if (routing.startsWith('/order')) {
            var value = routing.replaceFirst('/order/', '');
            int eventId = int.parse(value);
            return OrderScreen(eventId: eventId);
          }
          //Dashboard
          else if (routing.startsWith('/dashboard/')) {
            var value = routing.replaceFirst('/dashboard/', '');
            int eventId = int.parse(value);
            return DashboardScreen(eventId: eventId);
          }
          //Scanner
          else if (routing.startsWith('/scanner/')) {
            var value = routing.replaceFirst('/scanner/', '');
            int eventId = int.parse(value);
            return ScannerScreen(eventId: eventId);
          }
          //Menu
          else if (routing.startsWith('/menu/')) {
            var value = routing.replaceFirst('/menu/', '');
            int eventId = int.parse(value);
            return MenuScreen(eventId: eventId);
          }
          //Edit Ticket
          else if (routing.startsWith('/editTicket/')) {
            var value = routing.replaceFirst('/editTicket/', '');
            int ticketId = int.parse(value);
            return EditTicket(ticketId: ticketId);
          } else if (routing.startsWith('/createTicket/')) {
            var value = routing.replaceFirst('/createTicket/', '');
            int eventId = int.parse(value);
            return CreateTicket(eventId: eventId);
          } else {
            return null;
          }
        },
      );
  }
}
