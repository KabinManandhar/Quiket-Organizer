import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/getEventBlocProvider.dart';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/widgets/softContainer.dart';

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
    if (event.id == null &&
        event.name == null &&
        event.organizerId == null &&
        event.status == null &&
        event.picture == null &&
        event.type == null &&
        event.venue == null) {
      return Column(
        children: <Widget>[
          LoadingContainer(),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
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
        Divider(
          height: 20,
        ),
      ],
    );
  }
}

Widget buildTile2(BuildContext context, EventModel event) {
  if (event.id == null &&
      event.name == null &&
      event.organizerId == null &&
      event.status == null &&
      event.picture == null &&
      event.type == null &&
      event.venue == null) {
    return LoadingContainer();
  }
  return Container(
    child: Image.network("https://picsum.photos/485/384?image=1"),
  );
}
// ListTile(
//   onTap: () {
//     Navigator.pushNamed(context, '/${event.id}');
//   },
//   title: Text(event.name),
//   subtitle: Text('${event.sDate} points'),
//   trailing: Column(
//     children: [
//       Icon(Icons.comment),
//       Text('${event.sTime}'),
//     ],
//   ),
// ),
