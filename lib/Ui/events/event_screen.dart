import 'package:dot_tab_indicator/dot_tab_indicator.dart';

import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/widgets/event_card.dart';
import 'package:testawwpp/widgets/softButton.dart';

int bnbIndex;

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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              title: Text(
                'Events',
              ),
              elevation: 0,
              bottom: TabBar(
                indicator: DotTabIndicator(
                  indicatorColor: Colors.black,
                ),
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Current',
                      style: labelTextSmallStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Past",
                      style: labelTextSmallStyle,
                    ),
                  )
                ],
              ),
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
        ));
  }
}
