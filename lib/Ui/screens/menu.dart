import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/Ui/events/edit_event.dart';
import 'package:testawwpp/blocs/postBlocs/credentials/credentialBloc.dart';
import 'package:testawwpp/control/routes.dart';
import 'package:testawwpp/control/style.dart';
import 'package:testawwpp/resources/requests.dart';
import 'package:testawwpp/resources/secureStorage.dart';

class MenuScreen extends StatelessWidget {
  final int eventId;

  MenuScreen({this.eventId});

  Widget build(BuildContext context) {
    final bloc = blocCredential;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                bloc.logout();
                bloc.removeValues();
                Navigator.pushReplacementNamed(context, loginRoute);
              },
              icon:
                  Icon(AntDesign.logout, color: buttonColor, size: buttonSize),
            )
          ],
          title: Text(
            'Menu',
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(SimpleLineIcons.cloud_upload),
              onTap: () async {
                var _valueOfId = await secureStorage.read(key: 'id');
                var _token = await secureStorage.read(key: 'token');
                var _id = int.parse(_valueOfId);
                Map<String, dynamic> data = {'status': 1};
                var response = await req.putRequest(
                    data, '/organizers/$_id/events/$eventId', _token);
                var check = json.decode(response);
                if (check['success']) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Successfully Published.",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Unable to Publish. Please Try Again",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                }
              },
              title: Text(
                'Publish Event',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Publishes your Event making it online and visible to the users for interaction.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(SimpleLineIcons.cloud_download),
              onTap: () async {
                var _valueOfId = await secureStorage.read(key: 'id');
                var _token = await secureStorage.read(key: 'token');
                var _id = int.parse(_valueOfId);
                Map<String, dynamic> data = {'status': '0'};
                var response = await req.putRequest(
                    data, '/organizers/$_id/events/$eventId', _token);
                var check = json.decode(response);
                if (check['success']) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Successfully Unpublished.",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Unable to Unpublished.Please try Again",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                }
              },
              title: Text(
                'Unpublish Event',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Unpublishes your Event making it offline and invisible to the users for interaction.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(SimpleLineIcons.pencil),
              onTap: () {
                Navigator.pushNamed(context, '/editEvent/$eventId');
              },
              title: Text(
                'Edit Event',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Make changes to your event.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(SimpleLineIcons.event),
              onTap: () {
                Navigator.pushReplacementNamed(context, homeRoute);
              },
              title: Text(
                'Events',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Go back to All Events.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(AntDesign.linechart),
              onTap: () {},
              title: Text(
                'Dashboard',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Logistics of your Events Sales.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
