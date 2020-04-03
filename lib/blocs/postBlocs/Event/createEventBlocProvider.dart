import 'package:flutter/material.dart';
import 'createEventBloc.dart';
export 'createEventBloc.dart';

class CreateEventBlocProvider extends InheritedWidget {
  final createEventBloc = CreateEventBloc();

  CreateEventBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CreateEventBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CreateEventBlocProvider>()
        .createEventBloc;
  }
}
