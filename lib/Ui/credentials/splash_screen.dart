import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../control/routes.dart';
import '../../resources/secureStorage.dart';

final FocusNode focusName = FocusNode();
final FocusNode focusPhoneNo = FocusNode();
final FocusNode focusEmail = FocusNode();
final FocusNode focusPassword = FocusNode();

class SplashScreenQuiket extends StatefulWidget {
  @override
  _SplashScreenQuiketState createState() => _SplashScreenQuiketState();
}

class _SplashScreenQuiketState extends State<SplashScreenQuiket> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 0), () async {
      var ww = await secureStorage.readAll();
      if (ww['id'] != null && ww['token'] != null) {
        Navigator.pushReplacementNamed(context, homeRoute);
      } else {
        Navigator.pushNamed(context, loginRoute);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Hero(
          child: SvgPicture.asset(
            'assets/images/Logo.svg',
            height: 300,
            width: 300,
            color: Colors.grey[700],
          ),
          tag: 'svg',
        ),
      ),
    );
  }
}
