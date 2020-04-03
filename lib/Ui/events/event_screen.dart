import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_tab_indicator/dot_tab_indicator.dart';

import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/widgets/Event/event_card.dart';
import 'package:testawwpp/widgets/softButton.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var selectedIndex = 0;

  List<Widget> containers = [
    EventCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          title: Text(
            'Orders',
          ),
          elevation: 0,
        ),
      ),
      body: TabBarView(
        children: containers,
        // child:
      ),
      floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20, left: 25),
          padding: EdgeInsets.only(bottom: 30),
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTapCancel: () {
              Navigator.pushNamed(context, createEventRoute);
            },
            child: SoftButton(
              height: 70,
              width: 70,
              iconSize: 30,
              icon: MaterialIcons.add,
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          )),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        height: 70,
        color: Colors.grey[300],
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Colors.grey[300],
        buttonBackgroundColor: Theme.of(context).accentColor,
        items: <Widget>[
          Icon(Feather.file_text, color: buttonColor, size: buttonSize),
          Icon(MaterialCommunityIcons.face_profile,
              color: buttonColor, size: buttonSize),
          Icon(MaterialIcons.add, color: buttonColor, size: buttonSize),
          Icon(Feather.search, color: buttonColor, size: buttonSize),
          Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
        ],
      ),
    );
  }
}
