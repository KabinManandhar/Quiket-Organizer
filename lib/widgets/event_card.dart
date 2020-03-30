import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/getEventBlocProvider.dart';
import 'package:testawwpp/widgets/refresh.dart';

import 'event_list.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GetEventBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getEventIds,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          bloc.getIds();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.getEvent(snapshot.data[index]);
                return EventList(itemId: snapshot.data[index]);
              }),
        );
      },
    );
  }
}
