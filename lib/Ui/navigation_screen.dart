import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../control/style.dart';
import 'Order/order_screen.dart';
import 'Profile/profile.dart';
import 'screens/menu.dart';
import 'screens/scanner.dart';
import 'tickets/ticket_screen.dart';

class NavigationScreen extends StatefulWidget {
  final int eventId;
  int _id;
  String _token;

  NavigationScreen({this.eventId});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _screen = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: changeScreen(_screen, widget.eventId, widget._id),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 70,
        onTap: (index) {
          setState(() {
            _screen = index;
          });
        },
        color: Colors.grey[300],
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Colors.grey[300],
        buttonBackgroundColor: Theme.of(context).accentColor,
        items: <Widget>[
          Icon(Feather.file_text, color: buttonColor, size: buttonSize),
          Icon(MaterialCommunityIcons.ticket_outline,
              color: buttonColor, size: buttonSize),
          Icon(Ionicons.md_qr_scanner, color: buttonColor, size: buttonSize),
          Icon(AntDesign.user, color: buttonColor, size: buttonSize),
          Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
        ],
      ),
      //Text("${}"),
    );
  }

  Widget changeScreen(int screen, int id, int uId) {
    if (screen == 0) {
      return OrderScreen(
        eventId: id,
      );
    } else if (screen == 1) {
      return TicketScreen(
        eventId: id,
      );
    } else if (screen == 2) {
      return ScannerScreen(
        eventId: id,
      );
    } else if (screen == 3) {
      return ProfileScreen();
    } else if (screen == 4) {
      return MenuScreen(
        eventId: id,
      );
    } else {
      return Center(child: Text("How???"));
    }
  }
}
