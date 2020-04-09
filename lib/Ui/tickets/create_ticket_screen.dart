import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:testawwpp/blocs/postBlocs/Ticket/createTicketBlocProvider.dart';
import 'package:testawwpp/control/style.dart';

import 'package:testawwpp/widgets/softButton.dart';

List<String> _status = [
  'Visible',
  'Hidden',
];

String _currentSelectedStatus;
bool _priceVisibility = false;

//
class CreateTicket extends StatefulWidget {
  final eventId;

  const CreateTicket({Key key, this.eventId}) : super(key: key);
  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  Widget build(BuildContext context) {
    final bloc = CreateTicketBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tickets',
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                nameField(bloc),
                Container(height: 20),
                descriptionField(bloc),
                Container(height: 20),
                totalTicketField(bloc),
                Container(height: 20),
                dropDownStatus(bloc),
                Container(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Max/Min Tickets Allowed Per User",
                    style: labelTextSmallStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                maxMinAllowedField(bloc),
                Container(height: 20),
                priceSwitch(bloc),
                priceField(bloc),
                Container(height: 20),
                submitButton(bloc),
                Container(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField(CreateTicketBloc bloc) {
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
                  labelText: "Ticket Name"),
            ),
          );
        });
  }

  Widget descriptionField(CreateTicketBloc bloc) {
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
                  labelText: "Description"),
            ),
          );
        });
  }

  Widget priceSwitch(CreateTicketBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.type,
      builder: (context, snapshot) {
        return Container(
          child: SwitchListTile(
            selected: true,
            activeColor: Colors.grey[700],
            title: Text(
              'Paid Ticket?',
              style: labelTextSmallStyle,
            ),
            value: _priceVisibility,
            onChanged: (bool value) {
              setState(() {
                _priceVisibility = !_priceVisibility;
              });
            },
            secondary: Icon(FontAwesome.rupee),
          ),
        );
      },
    );
  }

  Widget totalTicketField(CreateTicketBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.totalTicket,
        builder: (context, snapshot) {
          return Container(
            child: TextField(
                textInputAction: TextInputAction.done,
                onChanged: bloc.changeTotalTicket,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                ],
                decoration: InputDecoration(
                    errorText: snapshot.error,
                    border: UnderlineInputBorder(),
                    labelStyle: labelTextStyle,
                    labelText: "Total Ticket")),
          );
        });
  }

  Widget priceField(CreateTicketBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.price,
        builder: (context, snapshot) {
          return AbsorbPointer(
            absorbing: !_priceVisibility,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              opacity: _priceVisibility ? 1 : 0,
              child: Container(
                child: TextField(
                    textInputAction: TextInputAction.done,
                    onChanged: bloc.changePrice,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                    ],
                    decoration: InputDecoration(
                        errorText: snapshot.error,
                        border: UnderlineInputBorder(),
                        labelStyle: labelTextStyle,
                        labelText: "Price")),
              ),
            ),
          );
        });
  }

  Widget maxMinAllowedField(CreateTicketBloc bloc) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<Object>(
              stream: bloc.maxAllowed,
              builder: (context, snapshot) {
                return TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                  ],
                  onChanged: bloc.changeMaxAallowed,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: UnderlineInputBorder(),
                      labelStyle: labelTextStyle,
                      labelText: "Maximum Allowed"),
                );
              }),
          StreamBuilder<Object>(
              stream: bloc.minAllowed,
              builder: (context, snapshot) {
                return TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: bloc.changeMinAllowed,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                  ],
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      border: UnderlineInputBorder(),
                      labelStyle: labelTextStyle,
                      labelText: "Minimum Allowed"),
                );
              }),
        ],
      ),
    );
  }

  Widget dropDownStatus(CreateTicketBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.vStatus,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Tooltip(
                  message: "Should the Ticket be visible to the User or not?",
                  child: Text(
                    "Visibility Status",
                    style: labelTextStyle,
                    textAlign: TextAlign.left,
                  ),
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

  Widget submitButton(CreateTicketBloc bloc) {
    return StreamBuilder<bool>(
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
                bloc.changeType(_priceVisibility);

                if (_currentSelectedStatus == _status[1]) {
                  bloc.changeStatus(false);
                } else {
                  bloc.changeStatus(true);
                }
                bloc.submit(widget.eventId);

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
