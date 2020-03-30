import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/getEventBlocProvider.dart';
import 'package:testawwpp/models/event_model.dart';

import 'loadingContainer.dart';

class EventList extends StatelessWidget {
  final int itemId;

  EventList({this.itemId});

  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.events,
      builder: (context, AsyncSnapshot<Map<int, Future<EventModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<EventModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            } else {
              return buildTile(context, itemSnapshot.data);
            }
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, EventModel event) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${event.id}');
          },
          title: Text(event.name),
          subtitle: Text('${event.description} points'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${event.status}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
