import 'package:flutter/material.dart';

const LargeTextSize = 60.0;
const MidTextSize = 40.0;
const BodyTextSize = 15.0;

const String FontName = 'NunitoSans';

const TextStyle AppBarText = TextStyle(
    fontFamily: FontName,
    fontWeight: FontWeight.w300,
    fontSize: LargeTextSize,
    color: Colors.black54);

const TextStyle TitleText = TextStyle(
    fontFamily: FontName,
    fontWeight: FontWeight.w500,
    fontSize: MidTextSize,
    color: Colors.grey);

const TextStyle Body1Text = TextStyle(
    fontFamily: FontName,
    fontWeight: FontWeight.w400,
    fontSize: BodyTextSize,
    color: Colors.black);

final TextStyle labelTextStyle =
    TextStyle(fontSize: 20, color: Colors.grey, fontFamily: FontName);
final TextStyle labelTextSmallStyle =
    TextStyle(fontSize: 15, color: Colors.grey, fontFamily: FontName);
final double buttonSize = 25;
final Color buttonColor = Colors.grey[700];
