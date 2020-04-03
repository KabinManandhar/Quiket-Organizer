import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/widgets/softContainer.dart';

import 'package:testawwpp/widgets/loadingContainer.dart';

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
            } else if (DateTime.parse(itemSnapshot.data.endDatetime)
                .isAfter(DateTime.now())) {
              return buildTile(context, itemSnapshot.data);
            }
            return Container();
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, EventModel event) {
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
