import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Order/getOrderBloc.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Order/getOrderBlocProvider.dart';
import 'package:QuicketOrganizer/blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../blocs/getBlocs/Event/getEventBlocProvider.dart';

class Refresh extends StatefulWidget {
  final Widget child;
  final eventId;

  Refresh({this.child, this.eventId});

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);
    final orderBloc = GetOrderBlocProvider.of(context);
    final ticketBloc = GetTicketBlocProvider.of(context);

    return LiquidPullToRefresh(
      color: Colors.grey[300],
      backgroundColor: Colors.grey,
      child: widget.child,
      onRefresh: () async {
        await bloc.getIds();
        await orderBloc.getIds(widget.eventId);
        await ticketBloc.getIds(widget.eventId);
      },
    );
  }
}
