import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../control/routes.dart';
import '../../resources/secureStorage.dart';

class SplashScreenQuiket extends StatefulWidget {
  @override
  _SplashScreenQuiketState createState() => _SplashScreenQuiketState();
}

class _SplashScreenQuiketState extends State<SplashScreenQuiket> {
  @override
  void initState() {
    super.initState();
    //secureStorage.deleteAll();
    Timer(Duration(seconds: 1), () async {
      var ww = await secureStorage.readAll();
      if (ww['id'] != null && ww['token'] != null) {
        Navigator.pushReplacementNamed(context, homeRoute);
      } else {
        Navigator.pushReplacementNamed(context, loginRoute);
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
