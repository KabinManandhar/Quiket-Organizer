import 'package:flutter/material.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import 'package:QuicketOrganizer/blocs/postBlocs/Credentials/credentialBlocProvider.dart';
import 'package:QuicketOrganizer/blocs/postBlocs/Event/createEventBlocProvider.dart';
import 'package:QuicketOrganizer/control/routes.dart';

import 'package:QuicketOrganizer/control/themedata.dart';

import 'blocs/getBlocs/Order/getOrderBlocProvider.dart';
import 'blocs/postBlocs/Ticket/createTicketBlocProvider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetOrderBlocProvider(
      child: GetTicketBlocProvider(
        child: CredentialsBlocProvider(
          child: CreateTicketBlocProvider(
            child: CreateEventBlocProvider(
              child: GetEventBlocProvider(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Quiket Organizers',
                  theme: themedata(),
                  onGenerateRoute: routes,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
