import 'package:flutter/material.dart';
import 'package:testawwpp/style.dart';

class SoftText extends StatefulWidget {
  final String label;
  final double fontSize;

  SoftText({
    Key key,
    this.label = "",
    this.fontSize = 30,
  }) : super(key: key);

  @override
  _SoftTextState createState() => _SoftTextState();
}

class _SoftTextState extends State<SoftText> {
  bool tapCheck = false;

  List<double> forClicked = [0, 0.1, 0.3, 1];
  List<double> forUnclicked = [0.1, 0.3, 0.8, 1];
  Color buttonColor = Colors.grey[300];
  Color lightShadow = Colors.white;
  Color darkShadow = Colors.grey[600];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          tapCheck = !tapCheck;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          tapCheck = !tapCheck;
        });
      },
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          fontSize: widget.fontSize,
          shadows: [
            Shadow(
              color: tapCheck ? lightShadow : darkShadow,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
            ),
            Shadow(
              color: tapCheck ? darkShadow : lightShadow,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        duration: Duration(milliseconds: 50),
        child: Text(
          widget.label,
          style: TextStyle(color: Colors.grey[500], fontFamily: FontName),
        ),
      ),
    );
  }
}
