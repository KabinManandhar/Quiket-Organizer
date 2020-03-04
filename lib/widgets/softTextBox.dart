import 'package:flutter/material.dart';

class SoftTextBox extends StatelessWidget {
  final TextField textField;
  final double height;

  SoftTextBox({Key key, this.textField, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      // padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: textField,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                offset: Offset(4.0, 4.0),
                blurRadius: 10.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: Colors.grey[400],
                offset: Offset(-4.0, -4.0),
                blurRadius: 10.0,
                spreadRadius: 1.0),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
      ),
    );
  }
}
