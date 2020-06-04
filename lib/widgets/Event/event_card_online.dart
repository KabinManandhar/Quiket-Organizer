import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Event/getEventBlocProvider.dart';

import 'package:QuicketOrganizer/widgets/refresh.dart';

import 'event_list_online.dart';

class EventCardOnline extends StatefulWidget {
  @override
  _EventCardOnlineState createState() => _EventCardOnlineState();
}

class _EventCardOnlineState extends State<EventCardOnline>
    with AutomaticKeepAliveClientMixin<EventCardOnline> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetEventBlocProvider.of(context);
    bloc.getIds();
    return StreamBuilder(
      stream: bloc.getEventIds,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.grey[700],
              size: 50.0,
            ),
          );
        }
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.getEvent(snapshot.data[index]);
                return EventListOnline(itemId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
