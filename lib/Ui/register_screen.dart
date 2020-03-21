import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testawwpp/blocs/credentialBloc.dart';
import 'package:testawwpp/routes.dart';
import 'package:testawwpp/style.dart';
import 'package:testawwpp/widgets/softButton.dart';

import 'package:testawwpp/blocs/provider.dart';

final FocusNode focusName = FocusNode();
final FocusNode focusPhoneNo = FocusNode();
final FocusNode focusEmail = FocusNode();
final FocusNode focusPassword = FocusNode();

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Container(
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
              Text('Sign Up', style: Theme.of(context).textTheme.title),
              Container(height: 20),
              nameField(bloc),
              Container(height: 20),
              phoneNoField(bloc),
              Container(height: 20),
              emailField(bloc),
              Container(height: 20),
              passwordField(bloc),
              Container(height: 20),
              registerButton(bloc),
              Container(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

Widget nameField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusName,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusName, focusPhoneNo);
              },
              onChanged: bloc.changeName,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: FontName),
                  labelText: "Name")),
        );
      });
}

Widget phoneNoField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.phoneNo,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusPhoneNo,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusPhoneNo, focusEmail);
              },
              onChanged: bloc.changePhoneNo,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: FontName),
                  labelText: "Phone Number")),
        );
      });
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

Widget registerButton(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.registerValid,
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          data = false;
        }
        return AbsorbPointer(
          absorbing: data ? false : true,
          child: GestureDetector(
              onTapDown: (TapDownDetails dets) {
                bloc.register();
                Navigator.pushReplacementNamed(context, homeRoute);
              },
              child: SoftButton(
                opacity: data ? true : false,
                icon: Ionicons.md_checkmark,
                mainAxisAlignment: MainAxisAlignment.end,
              )),
        );
      });
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}