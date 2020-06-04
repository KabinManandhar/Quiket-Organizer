import 'dart:async';

import 'package:flutter/material.dart';

import '../../blocs/getBlocs/Event/getEventBlocProvider.dart';
import '../../models/event_model.dart';
import '../loadingContainer.dart';
import '../softContainer.dart';

class EventListOffline extends StatelessWidget {
  final int eventId;

  EventListOffline({this.eventId});

  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.events,
      builder: (context, AsyncSnapshot<Map<int, Future<EventModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return FutureBuilder(
          future: snapshot.data[eventId],
          builder: (context, AsyncSnapshot<EventModel> eventSnapshot) {
            if (!eventSnapshot.hasData) {
              return Container();
            } else if (eventSnapshot.data.status == 0) {
              return buildTile(context, eventSnapshot.data);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, EventModel event) {
    print('Test');
    print(event.picture);
    print('test');
    if (event.status == null && event.name == null) {
      return Column(
        children: <Widget>[
          LoadingContainer(),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20,
        ),
        SoftContainer(
          height: 230,
          width: MediaQuery.of(context).size.width - 70,
          onClick: () {
            Navigator.pushReplacementNamed(context, '/navigation/${event.id}');
          },
          label: event.name,
          image: event.picture,
          status: event.status == 0 ? false : true,
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }
}
