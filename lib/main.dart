import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//           scaffoldBackgroundColor: Colors.grey[300],
//           primaryColor: Colors.grey[300],
//           appBarTheme: AppBarTheme(
//             textTheme: TextTheme(title: AppBarText),
//           ),
//           textTheme: TextTheme(title: TitleText, body1: Body1Text),
//           brightness: Brightness.light,
//           accentColor: Colors.black),
//       home: MyHomePage(title: 'Events'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var selectedIndex = 0;

//   void _incrementCounter() {
//     setState(() {});
//   }

//   List<Widget> containers = [
//     EventCard(),
//     Container(
//         child: Container(
//       width: 64,
//       height: 64,
//       decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(32),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey[300], offset: Offset(4, 4), blurRadius: 2),
//             BoxShadow(
//                 color: Colors.white, offset: Offset(-4, -4), blurRadius: 2),
//           ]),
//     ))
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double size1 = 20;
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(130),
//             child: AppBar(
//               title: Text(
//                 widget.title,
//               ),
//               elevation: 0,
//               bottom: TabBar(
//                 indicator: DotTabIndicator(
//                   indicatorColor: Colors.black,
//                 ),
//                 labelStyle: Theme.of(context).textTheme.body1,
//                 tabs: <Widget>[
//                   Tab(
//                     text: 'Current',
//                   ),
//                   Tab(
//                     text: "Past",
//                   )
//                 ],
//               ),
//             ),
//           ),
//           body: TabBarView(
//             children: containers,
//             // child:
//           ),
//           floatingActionButton: Container(
//             margin: EdgeInsets.only(bottom: 20),
//             child: FloatingActionButton(
//               onPressed: _incrementCounter,
//               elevation: 0,
//               hoverColor: Colors.green,
//               tooltip: 'Add Event',
//               child: Icon(Icons.add),
//             ),
//           ),
//           bottomNavigationBar: CurvedNavigationBar(
//               //index: 0,
//               height: 70,
//               color: Colors.grey[300],
//               animationDuration: Duration(milliseconds: 400),
//               backgroundColor: Colors.grey[300],
//               buttonBackgroundColor: Theme.of(context).accentColor,
//               items: <Widget>[
//                 Icon(Icons.note, color: Colors.black, size: size1),
//                 Icon(Icons.list, color: Colors.black, size: size1),
//                 Icon(Icons.compare_arrows, color: Colors.black, size: size1),
//                 Icon(Icons.play_circle_filled,
//                     color: Colors.black, size: size1),
//                 Icon(Icons.wallpaper, color: Colors.black, size: size1),
//               ]),
//         ));
//   }
// }
