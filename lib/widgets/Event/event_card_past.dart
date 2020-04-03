import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/widgets/Event/event_list_past.dart';
import 'package:testawwpp/widgets/refresh.dart';

class EventCardPast extends StatefulWidget {
  @override
  _EventCardPastState createState() => _EventCardPastState();
}

class _EventCardPastState extends State<EventCardPast>
    with AutomaticKeepAliveClientMixin<EventCardPast> {
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
                return EventListPast(itemId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
