import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:testawwpp/resources/EventApiProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/widgets/event_card.dart';
import 'package:testawwpp/widgets/softButton.dart';

final FocusNode focusName = FocusNode();
final FocusNode focusPhoneNo = FocusNode();
final FocusNode focusEmail = FocusNode();
final FocusNode focusPassword = FocusNode();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  List<Widget> containers = [
    EventCard(),
    Container(
        child: Container(
      width: 64,
      height: 64,
      child: Text('Dance'),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(32),
      ),
    ))
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
                  Navigator.pushNamed(context, createRoute);
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
              height: 70,
              color: Colors.grey[300],
              animationDuration: Duration(milliseconds: 400),
              backgroundColor: Colors.grey[300],
              buttonBackgroundColor: Theme.of(context).accentColor,
              items: <Widget>[
                Icon(Feather.file_text, color: buttonColor, size: buttonSize),
                Icon(MaterialCommunityIcons.ticket_outline,
                    color: buttonColor, size: buttonSize),
                Icon(AntDesign.scan1, color: buttonColor, size: buttonSize),
                Icon(AntDesign.linechart, color: buttonColor, size: buttonSize),
                Icon(SimpleLineIcons.menu,
                    color: buttonColor, size: buttonSize),
              ]),
        ));
  }
}
