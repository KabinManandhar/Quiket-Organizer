import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/control/style.dart';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/widgets/softContainer.dart';

import 'package:testawwpp/widgets/loadingContainer.dart';

class EventListPast extends StatelessWidget {
  final int itemId;

  EventListPast({this.itemId});

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
          builder: (context, AsyncSnapshot<EventModel> eventSnapshot) {
            if (!eventSnapshot.hasData) {
              return LoadingContainer();
            } else if (DateTime.parse(eventSnapshot.data.endDatetime)
                .isBefore(DateTime.now())) {
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
    if (event.status == null && event.name == null) {
      return LoadingContainer();
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
          onClick: () {},
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
