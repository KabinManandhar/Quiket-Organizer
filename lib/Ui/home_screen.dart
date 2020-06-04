import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:QuicketOrganizer/widgets/Event/event_card_offline.dart';

import '../blocs/postBlocs/credentials/credentialBloc.dart';
import '../control/routes.dart';
import '../control/style.dart';

import '../widgets/Event/event_card_online.dart';
import '../widgets/softButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  List<Widget> containers = [
    EventCardOffline(),
    EventCardOnline(),
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
                onPressed: () async {
                  bool check = await bloc.logout();
                  if (check) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[300],
                            title: Text(
                              "Logout Successfully.",
                              style: labelTextSmallStyle,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  bloc.removeValues();
                                  Navigator.pushReplacementNamed(
                                      context, loginRoute);
                                },
                                child: Text(
                                  'OK',
                                  style: labelTextSmallStyle,
                                ),
                              )
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[300],
                            title: Text(
                              "Logout Unsuccessful.",
                              style: labelTextSmallStyle,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: labelTextSmallStyle,
                                ),
                              )
                            ],
                          );
                        });
                  }
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
                    'Offline',
                    style: labelTextSmallStyle,
                  ),
                ),
                Tab(
                  child: Text(
                    "Online",
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
          ),
        ),
      ),
    );
  }
}
