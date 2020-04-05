import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_tab_indicator/dot_tab_indicator.dart';

import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/widgets/Event/event_card.dart';
import 'package:testawwpp/widgets/softButton.dart';

class MenuScreen extends StatelessWidget {
  final int eventId;

  MenuScreen({this.eventId});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          title: Text(
            'Menu',
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
