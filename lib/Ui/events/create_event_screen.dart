import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:QuicketOrganizer/blocs/postBlocs/Event/createEventBlocProvider.dart';
import 'package:QuicketOrganizer/control/style.dart';

import 'dart:async';

import 'package:QuicketOrganizer/widgets/softButton.dart';

DateTime _date = new DateTime.now();
TimeOfDay _time = new TimeOfDay.now();
String startDateLabel = DateFormat('yyyy-MM-dd').format(_date);
String startTimeLabel = "00:00";
String endDateLabel = DateFormat('yyyy-MM-dd').format(_date);
String endTimeLabel = "00:00";
String base64Image;
Future<File> eventPicture;
var _category = [
  'Conference',
  'Seminar or Talk',
  'Tradeshow, Consumer Show or Expo',
  'Convention',
  'Festival or Fair',
  'Concert or Performance',
  'Screening',
  'Dinner or Gala',
  'Class, Training or Workshop',
  'Meeting or Networking Event',
  'Party or Social Gathering',
  'Rally',
  'Tournament',
  'Game or Competition',
  'Race or Endurance Event',
  'Tour',
  'Attraction',
  'Camp, Trip or Retreat',
  'Appearance or Signing',
  'Other'
];
var _type = [
  'Music',
  'Business & Professional',
  'Food & Drink',
  'Community & Culture',
  'Performing & Visual Arts',
  'Film, Media & Entertainment',
  'Sports & Fitness',
  'Vehicle',
  'Health & Wellness',
  'Science & Technology',
  'Travel & Outdoor',
  'Charity & Causes',
  'Religion & Spirituality',
  'Family & Education',
  'Seasonal & Holiday',
  'Government & Policies',
  'Fashion & Beauty',
  'Home & Lifestyle',
  'Hobbies & Special Interest',
  'School Activities',
  'Other'
];
var _currentSelectedCategory;
var _currentSelectedType;

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  Widget build(BuildContext context) {
    final bloc = CreateEventBlocProvider.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                expandedHeight: 300.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: eventPicturePicker(bloc),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        nameField(bloc),
                        Container(height: 30),
                        descriptionField(bloc),
                        Container(height: 30),
                        venueField(bloc),
                        Container(height: 30),
                        dropDownCategory(bloc),
                        Container(height: 30),
                        dropDownType(bloc),
                        Container(height: 30),
                        startDateTimePicker(context, bloc),
                        Container(height: 30),
                        endDateTimePicker(context, bloc),
                        Container(height: 30),
                        submitButton(bloc),
                        Container(height: 40)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _startTimePicker(BuildContext context) async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: _time);
    if (pickedTime != null && pickedTime != _time) {
      setState(
        () {
          startTimeLabel = pickedTime.format(context).toString();
        },
      );
    }
  }

  _endTimePicker(BuildContext context) async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: _time);
    if (pickedTime != null && pickedTime != _time) {
      setState(() {
        endTimeLabel = pickedTime.format(context).toString();
      });
    }
  }

  _startDatePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2021));
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        startDateLabel = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  _endDatePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2021));
    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        endDateLabel = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<File> _chooseImage() {
    setState(() {
      eventPicture = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget eventPicturePicker(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.picture,
        builder: (context, snapshot) {
          return GestureDetector(
            onTapDown: (TapDownDetails details) {
              _chooseImage();
            },
            child: Container(
              child: FutureBuilder<File>(
                  future: eventPicture,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      // setState(() {
                      base64Image = 'data:image/png;base64,' +
                          base64Encode(snapshot.data.readAsBytesSync());
                      // });
                      return Image.file(snapshot.data, fit: BoxFit.cover);
                    } else {
                      return Icon(
                        MaterialIcons.add_a_photo,
                        size: 160,
                        color: Colors.grey,
                      );
                    }
                  }),
            ),
          );
        });
  }

  Widget startDateTimePicker(BuildContext context, CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.startDateTime,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Event Starts",
                  style: labelTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              FlatButton(
                  child: Row(children: [
                    Icon(
                      AntDesign.calendar,
                      color: Colors.grey,
                    ),
                    Container(width: 20),
                    Text(
                      startDateLabel,
                      style: labelTextSmallStyle,
                    )
                  ]),
                  onPressed: () {
                    _startDatePicker(context);
                  }),
              FlatButton(
                  child: Row(children: [
                    Icon(
                      AntDesign.clockcircleo,
                      color: Colors.grey,
                    ),
                    Container(width: 20),
                    Text(
                      startTimeLabel,
                      style: labelTextSmallStyle,
                    )
                  ]),
                  onPressed: () {
                    _startTimePicker(context);
                  }),
            ],
          );
        });
  }

  Widget endDateTimePicker(BuildContext context, CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.endDateTime,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Event Ends",
                  style: labelTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              FlatButton(
                  child: Row(children: [
                    Icon(
                      AntDesign.calendar,
                      color: Colors.grey,
                    ),
                    Container(width: 20),
                    Text(
                      endDateLabel,
                      style: labelTextSmallStyle,
                    )
                  ]),
                  onPressed: () {
                    _endDatePicker(context);
                  }),
              FlatButton(
                  child: Row(children: [
                    Icon(
                      AntDesign.clockcircleo,
                      color: Colors.grey,
                    ),
                    Container(width: 20),
                    Text(
                      endTimeLabel,
                      style: labelTextSmallStyle,
                    )
                  ]),
                  onPressed: () {
                    _endTimePicker(context);
                  }),
            ],
          );
        });
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

  Widget venueField(CreateEventBloc bloc) {
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

  Widget dropDownCategory(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.category,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Category",
                  style: labelTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: _category.map((String dropDownStringItem) {
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
                    _currentSelectedCategory = selectedValue;
                  });
                },
                value: _currentSelectedCategory,
              ),
            ],
          );
        });
  }

  Widget dropDownType(CreateEventBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.type,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Type",
                  style: labelTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: _type.map((String dropDownStringItem) {
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
                    _currentSelectedType = selectedValue;
                  });
                },
                value: _currentSelectedType,
              ),
            ],
          );
        });
  }

  Widget submitButton(CreateEventBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            data = false;
          }
          return AbsorbPointer(
            absorbing: data ? false : true,
            child: SoftButton(
              onClick: () {
                bloc.changeCategory(_currentSelectedCategory);
                bloc.changeType(_currentSelectedType);
                bloc.changePicture(base64Image);
                bloc.changeStartDateTime(startDateLabel + " " + startTimeLabel);
                bloc.changeEndDateTime(endDateLabel + " " + endTimeLabel);
                bloc.submit();
                Navigator.pop(context);
              },
              opacity: data ? true : false,
              icon: Ionicons.md_checkmark,
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          );
        });
  }
}
