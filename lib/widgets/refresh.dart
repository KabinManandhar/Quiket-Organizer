import 'package:flutter/material.dart';
import '../blocs/getBlocs/getEventBlocProvider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.getIds();
      },
    );
  }
}
