import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Clicked");
      },
      child: Container(
        color: Colors.grey[300],
        height: 200,
        width: 200,
        child: Image.network('https://via.placeholder.com/600/771796'),
      ),
    );
  }
}
