import 'package:flutter/material.dart';
import 'createTicketBloc.dart';

class CreateTicketBlocProvider extends InheritedWidget {
  final createTicketlBloc = CreateTicketBloc();

  CreateTicketBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CreateTicketBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CreateTicketBlocProvider>()
        .createTicketlBloc;
  }
}
