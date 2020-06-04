import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../../widgets/Ticket/ticket_card.dart';
import '../../widgets/softButton.dart';

class TicketScreen extends StatefulWidget {
  final int eventId;

  TicketScreen({this.eventId});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  Widget build(BuildContext context) {
    final bloc = GetTicketBlocProvider.of(context);
    bloc.getIds(widget.eventId);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            'Tickets',
          ),
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(100),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, left: 25),
        alignment: Alignment.bottomRight,
        child: SoftButton(
          onClick: () {
            Navigator.pushNamed(context, "/createTicket/${widget.eventId}");
          },
          height: 70,
          width: 70,
          iconSize: 30,
          icon: MaterialIcons.add,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: TicketCard(
            eventId: widget.eventId,
          )),
    );
  }
}
