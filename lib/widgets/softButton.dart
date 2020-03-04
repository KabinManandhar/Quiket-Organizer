import 'package:flutter/material.dart';

class SoftButton extends StatefulWidget {
  final icon;
  final String label;
  final double radius;
  final MainAxisAlignment mainAxisAlignment;
  final double height;
  final double width;
  final double iconSize;
  final double fontSize;

  SoftButton(
      {Key key,
      this.icon,
      this.label = "",
      this.radius = 62,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.height = 60,
      this.width = 60,
      this.fontSize = 30,
      this.iconSize = 20})
      : super(key: key);

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  bool tapCheck = false;
  List<Color> clicked = [
    Colors.grey[700],
    Colors.grey[600],
    Colors.grey[500],
    Colors.grey[200],
  ];
  List<Color> unclicked = [
    Colors.grey[200],
    Colors.grey[300],
    Colors.grey[400],
    Colors.grey[500],
  ];
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
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.all(20),
        child: Row(mainAxisAlignment: widget.mainAxisAlignment, children: [
          Text(widget.label),
          widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.grey[800],
                  size: widget.iconSize,
                )
              : Icon(null),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: buttonColor,
            boxShadow: [
              BoxShadow(
                  color: tapCheck ? lightShadow : darkShadow,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: tapCheck ? darkShadow : lightShadow,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: tapCheck ? clicked : unclicked,
                stops: tapCheck ? forClicked : forUnclicked)),
        duration: Duration(milliseconds: 100),
      ),
    );
  }
}
