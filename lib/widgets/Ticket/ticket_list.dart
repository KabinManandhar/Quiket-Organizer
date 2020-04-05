import 'dart:async';

import 'package:flutter/material.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../../control/style.dart';
import '../../models/ticket_model.dart';
import '../loadingTicketContainer.dart';

class TicketList extends StatelessWidget {
  final int ticketId;

  TicketList({this.ticketId});

  Widget build(context) {
    final bloc = GetTicketBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.tickets,
      builder:
          (context, AsyncSnapshot<Map<int, Future<TicketModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTicketContainer();
        }

        return FutureBuilder(
          future: snapshot.data[ticketId],
          builder: (context, AsyncSnapshot<TicketModel> ticketSnapshot) {
            if (!ticketSnapshot.hasData) {
              return LoadingTicketContainer();
            }
            return buildTile(context, ticketSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, TicketModel ticket) {
    if (ticket.status == null && ticket.name == null) {
      return Column(
        children: <Widget>[
          LoadingTicketContainer(),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            print("WAU boiii");
          },
          title: Text(
            ticket.name,
            style: labelTextStyle,
          ),
          subtitle: Text(ticket.status == 0 ? "Not on Sale" : "On Sale"),
          trailing: Text(
            ticket.price == 0 ? 'Free' : 'Rs.${ticket.price}',
            style: labelTextStyle,
          ),
        ),
        Divider(
          height: 8,
        ),
      ],
    );
  }
}
