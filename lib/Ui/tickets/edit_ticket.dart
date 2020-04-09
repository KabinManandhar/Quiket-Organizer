import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:testawwpp/blocs/postBlocs/Ticket/createTicketBlocProvider.dart';
import 'package:testawwpp/control/style.dart';
import 'package:testawwpp/models/ticket_model.dart';
import 'package:testawwpp/resources/TicketApiProvider.dart';
import 'package:testawwpp/widgets/softButton.dart';

var _status = [
  'Visible',
  'Hidden',
];

var _currentSelectedStatus;
bool _priceVisibility = false;

//
class EditTicket extends StatefulWidget {
  final ticketId;

  const EditTicket({Key key, this.ticketId}) : super(key: key);

  @override
  _EditTicketState createState() => _EditTicketState();
}

class _EditTicketState extends State<EditTicket> {
  Widget build(BuildContext context) {
    final bloc = CreateTicketBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Ticket',
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
            child: getTicketData(widget.ticketId, bloc),
          ),
        ),
      ),
    );
  }

  Widget getTicketData(ticketId, bloc) {
    return FutureBuilder(
      future: TicketApiProvider().getTicket(ticketId),
      builder: (context, AsyncSnapshot<TicketModel> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        var ticketData = snapshot.data;
        return Column(
          children: <Widget>[
            nameField(bloc, ticketData.name),
            Container(height: 20),
            descriptionField(bloc, ticketData.description),
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
            maxMinAllowedField(
                bloc, ticketData.maxTicket, ticketData.minTicket),
            Container(height: 20),
            priceSwitch(bloc, ticketData.price),
            priceField(bloc, ticketData.price),
            Container(height: 20),
            submitButton(bloc, ticketData),
            Container(height: 40)
          ],
        );
      },
    );

    //return ticketData;
  }

  Widget nameField(CreateTicketBloc bloc, String name) {
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
                  labelText: "Ticket Name",
                  hintStyle: labelTextSmallStyle,
                  hintText: name),
            ),
          );
        });
  }

  Widget descriptionField(CreateTicketBloc bloc, String description) {
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
                  labelText: "Description",
                  hintStyle: labelTextSmallStyle,
                  hintText: description),
            ),
          );
        });
  }

  Widget priceSwitch(CreateTicketBloc bloc, int price) {
    return StreamBuilder<bool>(
      stream: bloc.type,
      builder: (context, snapshot) {
        return Container(
          child: SwitchListTile(
            selected: (price == null || price == 0) ? false : true,
            activeColor: Colors.grey[700],
            title: Text(
              'Paid Ticket?',
              style: labelTextSmallStyle,
            ),
            value: _priceVisibility,
            onChanged: (bool value) {
              setState(() {
                _priceVisibility = !_priceVisibility;
                bloc.changeType(_priceVisibility);
              });
            },
            secondary: Icon(FontAwesome.rupee),
          ),
        );
      },
    );
  }

  Widget priceField(CreateTicketBloc bloc, int price) {
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
                    labelText: "Price",
                    hintStyle: labelTextSmallStyle,
                    hintText: 'Rs.' + price.toString(),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget maxMinAllowedField(CreateTicketBloc bloc, max, min) {
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
                    labelText: "Maximum Allowed",
                    hintStyle: labelTextSmallStyle,
                    hintText: max.toString(),
                  ),
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
                    labelText: "Minimum Allowed",
                    hintStyle: labelTextSmallStyle,
                    hintText: min.toString(),
                  ),
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

  Widget submitButton(CreateTicketBloc bloc, TicketModel ticketData) {
    return StreamBuilder<bool>(
        stream: bloc.editValid,
        builder: (context, snapshot) {
          var data = snapshot.data;

          if (data == null) {
            data = false;
          }
          return AbsorbPointer(
            absorbing: data ? false : true,
            child: SoftButton(
              onClick: () {
                if (_currentSelectedStatus == _status[0]) {
                  bloc.changeStatus(false);
                } else if (_currentSelectedStatus == _status[1]) {
                  bloc.changeStatus(true);
                }
                bloc.edit(widget.ticketId, ticketData);
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
