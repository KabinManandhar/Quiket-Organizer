import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final int eventId;

  DashboardScreen({this.eventId});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          title: Text(
            'Dashboard',
          ),
          elevation: 0,
        ),
      ),
      body: Container(),
    );
  }
}
