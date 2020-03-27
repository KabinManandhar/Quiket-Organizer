import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testawwpp/blocs/createEventBloc.dart';
import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';

import 'dart:async';
import '../blocs/createEventBlocProvider.dart';
import '../widgets/softButton.dart';

DateTime _date = new DateTime.now();
TimeOfDay _time = new TimeOfDay.now();
String startDateLabel = DateFormat('yyyy-MM-dd').format(_date);
String startTimeLabel = "00:00";
String endDateLabel = DateFormat('yyyy-MM-dd').format(_date);
String endTimeLabel = "00:00";

var _status = [
  'Visible',
  'Hidden',
];
var _currentSelectedType = 'Music';
var _currentSelectedStatus;

class CreateTicket extends StatefulWidget {
  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  Widget build(BuildContext context) {
    final bloc = CreateEventBlocProvider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          'Tickets',
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              nameField(bloc),
              Container(height: 30),
              descriptionField(bloc),
              Container(height: 30),
              priceField(bloc),
              Container(height: 30),
              dropDownStatus(bloc),
              Container(height: 30),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Max/Min Tickets Allowed Per User",
                  style: labelTextSmallStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              maxMinAllowedField(bloc),
              Container(height: 30),
              buttonList(bloc),
              Container(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.name,
        builder: (context, snapshot) {
          return Container(
            child: TextField(
                textInputAction: TextInputAction.done,
                onChanged: bloc.changeName,
                decoration: InputDecoration(
                    errorText: snapshot.error,
                    border: UnderlineInputBorder(),
                    labelStyle: labelTextStyle,
                    labelText: "Name the Event")),
          );
        });
  }

  Widget descriptionField(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.description,
        builder: (context, snapshot) {
          return Container(
            child: TextField(
                textInputAction: TextInputAction.done,
                onChanged: bloc.changeDescription,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    errorText: snapshot.error,
                    border: UnderlineInputBorder(),
                    labelStyle: labelTextStyle,
                    labelText: "Describe the Event")),
          );
        });
  }

  Widget priceField(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.venue,
        builder: (context, snapshot) {
          return Container(
            child: TextField(
                textInputAction: TextInputAction.done,
                onChanged: bloc.changeVenue,
                decoration: InputDecoration(
                    errorText: snapshot.error,
                    border: UnderlineInputBorder(),
                    labelStyle: labelTextStyle,
                    labelText: "Venue of Event")),
          );
        });
  }

  Widget maxMinAllowedField(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.name,
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: <Widget>[
                TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: bloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: UnderlineInputBorder(),
                      labelStyle: labelTextStyle,
                      labelText: "Maximum Allowed"),
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: bloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: UnderlineInputBorder(),
                      labelStyle: labelTextStyle,
                      labelText: "Minimum Allowed"),
                ),
              ],
            ),
          );
        });
  }

  Widget dropDownStatus(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.category,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Visibility Status",
                  style: labelTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: _status.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    child: Text(
                      dropDownStringItem,
                      style: labelTextSmallStyle,
                    ),
                    value: dropDownStringItem,
                  );
                }).toList(),
                onChanged: (String selectedValue) {
                  setState(() {
                    _currentSelectedStatus = selectedValue;
                  });
                },
                value: _currentSelectedStatus,
              ),
            ],
          );
        });
  }

  Widget buttonList(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          var data = snapshot.data;
          print(data);
          if (data == null) {
            data = false;
          }
          return AbsorbPointer(
            absorbing: data ? false : true,
            child: GestureDetector(
                onTapCancel: () {
                  bloc.changeCategory(_currentSelectedStatus);
                  bloc.changeType(_currentSelectedType);

                  bloc.changeStartDateTime(
                      startDateLabel + " " + startTimeLabel);
                  bloc.changeEndDateTime(endDateLabel + " " + endTimeLabel);
                  bloc.submit();
                  // Navigator.pushReplacementNamed(context, homeRoute);
                },
                child: SoftButton(
                  opacity: data ? true : false,
                  icon: Ionicons.md_checkmark,
                  mainAxisAlignment: MainAxisAlignment.end,
                )),
          );
        });
  }
}
