import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testawwpp/blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import 'package:testawwpp/widgets/refresh.dart';

import 'ticket_list.dart';

class TicketCard extends StatefulWidget {
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard>
    with AutomaticKeepAliveClientMixin<TicketCard> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetTicketBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getTicketsIds,
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
                bloc.getTicket(snapshot.data[index]);
                return TicketList(ticketId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
