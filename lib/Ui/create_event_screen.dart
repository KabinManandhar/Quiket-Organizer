import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:testawwpp/blocs/credentialBloc.dart';
import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';

import 'dart:async';
import '../blocs/provider.dart';
import '../widgets/softButton.dart';

final FocusNode _focusName = FocusNode();
final FocusNode _focusPhoneNo = FocusNode();
final FocusNode _focusEmail = FocusNode();
final FocusNode _focusPassword = FocusNode();
final TextStyle textStyle =
    TextStyle(fontSize: 25, color: Colors.grey, fontFamily: FontName);
DateTime _date = new DateTime.now();
TimeOfDay _time = new TimeOfDay.now();
String dateLabel = DateFormat('yyyy-MM-dd').format(_date);
String timeLabel = "00:00";

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  _datePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2021));
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        dateLabel = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  _timePicker(BuildContext context) async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: _time);
    if (pickedTime != null && pickedTime != _time) {
      setState(() {
        timeLabel = pickedTime.format(context).toString();
      });
    }
  }

  Widget datePicker(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 20),
        FlatButton(child: Text(dateLabel), onPressed: _datePicker(context)),
        // GestureDetector(
        //     onTapCancel: () {
        //       _timePicker(context);
        //       _datePicker(context);
        //     },
        //     child: SoftButton(
        //       icon: AntDesign.calendar,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //     )),
        Container(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Start Date: $dateLabel',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: FontName)),
            Text('Start Time: $timeLabel',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: FontName))
          ],
        ),
      ],
    );
  }

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
              Container(height: 20),
              nameField(bloc),
              Container(height: 20),
              descriptionField(bloc),
              Container(height: 20),
              datePicker(context),
              Container(height: 20),
              eventPicture(bloc),
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
              focusNode: _focusName,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, _focusName, _focusPhoneNo);
              },
              onChanged: bloc.changeName,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: textStyle,
                  labelText: "Name the Event")),
        );
      });
}

Widget descriptionField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.phoneNo,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: _focusPhoneNo,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, _focusPhoneNo, _focusEmail);
              },
              onChanged: bloc.changePhoneNo,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: textStyle,
                  labelText: "Describe the Event")),
        );
      });
}

Widget startDateTimeField(BuildContext context) {
  return Row(children: <Widget>[]);
}

Widget eventPicture(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
            focusNode: _focusPassword,
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                border: UnderlineInputBorder(),
                labelStyle: textStyle,
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
              onTapCancel: () {
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
