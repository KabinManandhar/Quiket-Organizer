import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../blocs/postBlocs/credentials/credentialBloc.dart';
import '../control/routes.dart';
import '../control/style.dart';
import '../widgets/Event/event_card.dart';
import '../widgets/Event/event_card_past.dart';
import '../widgets/softButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  List<Widget> containers = [
    EventCard(),
    EventCardPast(),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = blocCredential;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    bloc.logout();
                    bloc.removeValues();
                    Navigator.pushReplacementNamed(context, loginRoute);
                  },
                  icon: Icon(AntDesign.logout,
                      color: buttonColor, size: buttonSize),
                )
              ],
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
          body: Container(
            height: MediaQuery.of(context).size.height - 270,
            child: TabBarView(
              children: containers,
              // child:
            ),
          ),
          floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 10, left: 25),
              alignment: Alignment.bottomCenter,
              child: SoftButton(
                onClick: () => Navigator.pushNamed(context, createEventRoute),
                height: 70,
                width: 70,
                iconSize: 30,
                icon: MaterialIcons.add,
                mainAxisAlignment: MainAxisAlignment.end,
              )),
          // bottomNavigationBar: CurvedNavigationBar(
          //   index: 0,
          //   onTap: (index) {
          //     setState(() {
          //       selectedIndex = index;
          //     });
          //   },
          //   height: 70,
          //   color: Colors.grey[300],
          //   animationDuration: Duration(milliseconds: 400),
          //   backgroundColor: Colors.grey[300],
          //   buttonBackgroundColor: Theme.of(context).accentColor,
          //   items: <Widget>[
          //     Icon(Feather.file_text, color: buttonColor, size: buttonSize),
          //     Icon(MaterialCommunityIcons.face_profile,
          //         color: buttonColor, size: buttonSize),
          //     Icon(MaterialIcons.add, color: buttonColor, size: buttonSize),
          //     Icon(Feather.search, color: buttonColor, size: buttonSize),
          //     Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
          //   ],
          // ),
        ));
  }
}
