import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:QuicketOrganizer/models/organizer_model.dart';

import '../../control/style.dart';

import '../../resources/authProvider.dart';
import '../../widgets/softButton.dart';

class ProfileScreen extends StatelessWidget {
  final _auth = AuthProvider();

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _auth.getProfile(),
      builder: (context, AsyncSnapshot<OrganizerModel> snapshot) {
        if (snapshot.hasData == false) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300]);
        }
        if (snapshot.hasData) {
          OrganizerModel organizer = snapshot.data;
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
                    actions: <Widget>[
                      edit(context, organizer.id),
                    ],
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: organizer.picture == null
                          ? Icon(
                              MaterialIcons.photo,
                              size: 160,
                              color: Colors.grey,
                            )
                          : Image.network(
                              "http://192.168.100.70:8000" + organizer.picture,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Name',
                              style: labelTextStyle,
                            ),
                            nameField(organizer.name),
                            Container(height: 30),
                            Text(
                              'Email',
                              style: labelTextStyle,
                            ),
                            emailField(organizer.email),
                            Container(height: 30),
                            Text(
                              'Phone No',
                              style: labelTextStyle,
                            ),
                            phoneNoField(organizer.phoneNo),
                            Container(height: 30),
                            Text(
                              'Description',
                              style: labelTextStyle,
                            ),
                            descriptionField(organizer.description),
                            Container(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  nameField(name) {
    return Text(
      name,
      style: titleText,
    );
  }

  emailField(email) {
    return Text(
      email,
      style: titleText,
    );
  }

  phoneNoField(phoneNo) {
    return Text(
      phoneNo,
      style: titleText,
    );
  }

  descriptionField(description) {
    return description == null
        ? Container()
        : AutoSizeText(
            description,
            minFontSize: 15,
            maxLines: 10,
            style: titleText,
          );
  }

  edit(context, id) {
    return FlatButton(
      child: Icon(MaterialCommunityIcons.pencil),
      onPressed: () {
        Navigator.pushNamed(context, "/updateProfile/$id");
      },
    );
  }
}
