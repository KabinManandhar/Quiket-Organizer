import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testawwpp/style.dart';
import 'package:testawwpp/widgets/softButton.dart';
import 'package:testawwpp/widgets/softText.dart';
import 'package:testawwpp/widgets/softTextBox.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/Logo.svg',
                height: 250,
                width: 250,
                color: Colors.grey[700],
              ),
              Container(height: 40),
              Text('Login', style: Theme.of(context).textTheme.title),
              emailField(),
              passwordField(),
              loginButton(),
              Container(height: 40),
              SoftText(
                label: "Register",
                fontSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget emailField() {
  return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SoftTextBox(
        textField: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontFamily: FontName),
                hintText: "Email Address")),
      ));
}

Widget passwordField() {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: SoftTextBox(
      textField: TextField(
          textAlign: TextAlign.center,
          obscureText: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey, fontFamily: FontName),
              hintText: "Password")),
    ),
  );
}

Widget loginButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: GestureDetector(
        onTapDown: (TapDownDetails dets) {
          print("tapppppp");
        },
        child: SoftButton(
          opacity: false,
          icon: AntDesign.login,
          mainAxisAlignment: MainAxisAlignment.end,
        )),
  );
}
