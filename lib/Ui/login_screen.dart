import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testawwpp/blocs/credentialBloc.dart';
import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:testawwpp/widgets/softButton.dart';
import 'package:testawwpp/widgets/softText.dart';

import 'package:testawwpp/blocs/provider.dart';

final FocusNode focusEmail = FocusNode();
final FocusNode focusPassword = FocusNode();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  child: SvgPicture.asset(
                    'assets/images/Logo.svg',
                    height: 100,
                    width: 100,
                    color: Colors.grey[700],
                  ),
                  tag: 'svg',
                ),
                Container(height: 40),
                Text('Login', style: Theme.of(context).textTheme.title),
                Container(height: 40),
                emailField(bloc),
                Container(height: 20),
                passwordField(bloc),
                Container(height: 20),
                loginButton(bloc),
                Container(height: 200),
                signUp(bloc, context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget emailField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusEmail,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusEmail, focusPassword);
              },
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: FontName),
                  labelText: "Email Address")),
        );
      });
}

Widget passwordField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
            focusNode: focusPassword,
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey, fontFamily: FontName),
                labelText: "Password"));
      });
}

Widget loginButton(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          data = false;
        }
        return AbsorbPointer(
          absorbing: data ? false : true,
          child: GestureDetector(
              onTapCancel: () {
                bloc.submit();
                Navigator.pushReplacementNamed(context, homeRoute);
              },
              child: SoftButton(
                opacity: data ? true : false,
                icon: AntDesign.login,
                mainAxisAlignment: MainAxisAlignment.end,
              )),
        );
      });
}

Widget signUp(CredentialsBloc bloc, BuildContext context) {
  return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapCancel: () {
        Navigator.pushReplacementNamed(context, registerRoute);
      },
      child: SoftText(
        label: "Sign Up",
      ));
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
