import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_tab_indicator/dot_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:testawwpp/widgets/event_card.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFFF1F2F6),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(title: AppBarText),
          ),
          textTheme: TextTheme(title: TitleText, body1: Body1Text),
          //textTheme: TextTheme(title: TitleText, body1: Body1Text),
          brightness: Brightness.light,
          accentColor: Colors.black //Color(0xFFFFE500),
          ),
      home: MyHomePage(title: 'Events'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<Widget> containers = [
    EventCard(),
    //Container(color: Colors.white),
    Container(
        child: Container(
      width: 64,
      height: 54,
      decoration: BoxDecoration(
          color: Color(0xFFF1F2F6),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFDADFF0), offset: Offset(4, 4), blurRadius: 2),
            BoxShadow(
                color: Colors.white, offset: Offset(-4, -4), blurRadius: 2),
          ]),
    ))
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
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
              //height: 60,
              color: Color(0xFFF1F2F4),
              animationDuration: Duration(milliseconds: 400),
              backgroundColor: Color(0xFFF1F2F6),
              buttonBackgroundColor: Theme.of(context).accentColor,
              items: <Widget>[
                Icon(Icons.add, size: 30),
                Icon(Icons.list, size: 30),
                Icon(Icons.compare_arrows, size: 30),
                Icon(Icons.play_circle_filled, size: 30),
                Icon(Icons.wallpaper, size: 30),
              ]),
        ));
  }
}
