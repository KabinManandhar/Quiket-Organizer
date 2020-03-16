import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:testawwpp/resources/EventApiProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  void _incrementCounter() {
    setState(() {});
  }

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
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset(4, 4), blurRadius: 2),
            BoxShadow(
                color: Colors.white, offset: Offset(-4, -4), blurRadius: 2),
          ]),
    ))
  ];

  @override
  Widget build(BuildContext context) {
    double size1 = 25;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              title: Text(
                widget.title,
              ),
              elevation: 0,
              bottom: TabBar(
                indicator: DotTabIndicator(
                  indicatorColor: Colors.black,
                ),
                labelStyle: Theme.of(context).textTheme.body1,
                tabs: <Widget>[
                  Tab(
                    text: 'Current',
                  ),
                  Tab(
                    text: "Past",
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
            margin: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              elevation: 0,
              hoverColor: Colors.green,
              tooltip: 'Add Event',
              child: Icon(Icons.add),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
              //index: 0,
              height: 70,
              color: Colors.grey[300],
              animationDuration: Duration(milliseconds: 400),
              backgroundColor: Colors.grey[300],
              buttonBackgroundColor: Theme.of(context).accentColor,
              items: <Widget>[
                Icon(Feather.file_text, color: Colors.black, size: size1),
                Icon(MaterialCommunityIcons.ticket_outline,
                    color: Colors.black, size: size1),
                Icon(AntDesign.scan1, color: Colors.black, size: size1),
                Icon(AntDesign.linechart, color: Colors.black, size: size1),
                Icon(SimpleLineIcons.menu, color: Colors.black, size: size1),
              ]),
        ));
  }
}
