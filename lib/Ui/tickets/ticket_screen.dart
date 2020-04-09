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
          child: TicketCard()),
    );
  }
}

// floatingActionButton: Container(
//           margin: EdgeInsets.only(bottom: 20, left: 25),
//           padding: EdgeInsets.only(bottom: 30),
//           alignment: Alignment.bottomCenter,
//           child: GestureDetector(
//             onTapCancel: () {
//               Navigator.pushNamed(context, createEventRoute);
//             },
//             child: SoftButton(
//               height: 70,
//               width: 70,
//               iconSize: 30,
//               icon: MaterialIcons.add,
//               mainAxisAlignment: MainAxisAlignment.end,
//             ),
//           )),
//       bottomNavigationBar: CurvedNavigationBar(
//         index: 0,
//         height: 70,
//         color: Colors.grey[300],
//         animationDuration: Duration(milliseconds: 400),
//         backgroundColor: Colors.grey[300],
//         buttonBackgroundColor: Theme.of(context).accentColor,
//         items: <Widget>[
//           Icon(Feather.file_text, color: buttonColor, size: buttonSize),
//           Icon(MaterialCommunityIcons.face_profile,
//               color: buttonColor, size: buttonSize),
//           Icon(MaterialIcons.add, color: buttonColor, size: buttonSize),
//           Icon(Feather.search, color: buttonColor, size: buttonSize),
//           Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
//         ],
//       ),
