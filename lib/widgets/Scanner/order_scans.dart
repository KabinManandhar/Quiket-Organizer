import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../refresh.dart';
import 'scanning.dart';

class OrderScans extends StatefulWidget {
  final qrData;

  const OrderScans({Key key, this.qrData}) : super(key: key);

  @override
  _OrderScansState createState() => _OrderScansState();
}

class _OrderScansState extends State<OrderScans>
    with AutomaticKeepAliveClientMixin<OrderScans> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetOrderBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getOrdersIds,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.grey[700],
              size: 50.0,
            ),
          );
        }
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.getOrder(snapshot.data[index]);
              return Scanning(
                orderId: snapshot.data[index],
                qrData: widget.qrData,
              );
            });
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// _startTimePicker(BuildContext context) async {
//     final TimeOfDay pickedTime =
//         await showTimePicker(context: context, initialTime: _time);
//     if (pickedTime != null && pickedTime != _time) {
//       setState(() {
//         startTimeLabel = pickedTime.format(context).toString();
//       });
//     }
//   }

//   _endTimePicker(BuildContext context) async {
//     final TimeOfDay pickedTime =
//         await showTimePicker(context: context, initialTime: _time);
//     if (pickedTime != null && pickedTime != _time) {
//       setState(() {
//         endTimeLabel = pickedTime.format(context).toString();
//       });
//     }
//   }

//   _startDatePicker(BuildContext context) async {
//     final DateTime pickedDate = await showDatePicker(
//         context: context,
//         initialDate: _date,
//         firstDate: DateTime(2018),
//         lastDate: DateTime(2021));
//     if (pickedDate != null && pickedDate != _date) {
//       setState(() {
//         startDateLabel = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     }
//   }

//   _endDatePicker(BuildContext context) async {
//     final DateTime pickedDate = await showDatePicker(
//         context: context,
//         initialDate: _date,
//         firstDate: DateTime(2018),
//         lastDate: DateTime(2021));
//     if (pickedDate != null && pickedDate != _date) {
//       setState(() {
//         endDateLabel = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     }
//   }

//   Future<File> _chooseImage() {
//     setState(() {
//       eventPicture = ImagePicker.pickImage(source: ImageSource.gallery);
//     });
//   }

//   Widget eventPicturePicker(CreateEventBloc bloc, picture) {
//     return StreamBuilder<Object>(
//         stream: bloc.picture,
//         builder: (context, snapshot) {
//           return GestureDetector(
//             onTapDown: (TapDownDetails details) {
//               _chooseImage();
//             },
//             child: Container(
//               child: FutureBuilder<File>(
//                   future: eventPicture,
//                   builder: (context, snapshot) {
//                     if (snapshot.data != null) {
//                       // setState(() {
//                       base64Image = 'data:image/png;base64,' +
//                           base64Encode(snapshot.data.readAsBytesSync());
//                       // });
//                       return Image.file(snapshot.data, fit: BoxFit.cover);
//                     } else {
//                       return Image.network(
//                         "http://192.168.100.70:8000" + picture,
//                         fit: BoxFit.cover,
//                       );
//                     }
//                   }),
//             ),
//           );
//         });
//   }

//   Widget startDateTimePicker(BuildContext context, CreateEventBloc bloc) {
//     return StreamBuilder<Object>(
//         stream: bloc.startDateTime,
//         builder: (context, snapshot) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Event Starts",
//                   style: labelTextStyle,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               FlatButton(
//                   child: Row(children: [
//                     Icon(
//                       AntDesign.calendar,
//                       color: Colors.grey,
//                     ),
//                     Container(width: 20),
//                     Text(
//                       startDateLabel,
//                       style: labelTextSmallStyle,
//                     )
//                   ]),
//                   onPressed: () {
//                     _startDatePicker(context);
//                   }),
//               FlatButton(
//                   child: Row(children: [
//                     Icon(
//                       AntDesign.clockcircleo,
//                       color: Colors.grey,
//                     ),
//                     Container(width: 20),
//                     Text(
//                       startTimeLabel,
//                       style: labelTextSmallStyle,
//                     )
//                   ]),
//                   onPressed: () {
//                     _startTimePicker(context);
//                   }),
//             ],
//           );
//         });
//   }

//   Widget endDateTimePicker(BuildContext context, CreateEventBloc bloc) {
//     return StreamBuilder<Object>(
//         stream: bloc.endDateTime,
//         builder: (context, snapshot) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Event Ends",
//                   style: labelTextStyle,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               FlatButton(
//                   child: Row(children: [
//                     Icon(
//                       AntDesign.calendar,
//                       color: Colors.grey,
//                     ),
//                     Container(width: 20),
//                     Text(
//                       endDateLabel,
//                       style: labelTextSmallStyle,
//                     )
//                   ]),
//                   onPressed: () {
//                     _endDatePicker(context);
//                   }),
//               FlatButton(
//                   child: Row(children: [
//                     Icon(
//                       AntDesign.clockcircleo,
//                       color: Colors.grey,
//                     ),
//                     Container(width: 20),
//                     Text(
//                       endTimeLabel,
//                       style: labelTextSmallStyle,
//                     )
//                   ]),
//                   onPressed: () {
//                     _endTimePicker(context);
//                   }),
//             ],
//           );
//         });
//   }

//   Widget nameField(CreateEventBloc bloc, String name) {
//     return StreamBuilder<Object>(
//         stream: bloc.name,
//         builder: (context, snapshot) {
//           return Container(
//             child: TextField(
//                 textInputAction: TextInputAction.done,
//                 onChanged: bloc.changeName,
//                 decoration: InputDecoration(
//                     errorText: snapshot.error,
//                     border: UnderlineInputBorder(),
//                     labelStyle: labelTextStyle,
//                     labelText: "Name the Event",
//                     hintStyle: labelTextSmallStyle,
//                     hintText: name)),
//           );
//         });
//   }

//   Widget descriptionField(CreateEventBloc bloc, String description) {
//     return StreamBuilder<Object>(
//         stream: bloc.description,
//         builder: (context, snapshot) {
//           return Container(
//             child: TextField(
//                 textInputAction: TextInputAction.done,
//                 onChanged: bloc.changeDescription,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 decoration: InputDecoration(
//                     errorText: snapshot.error,
//                     border: UnderlineInputBorder(),
//                     labelStyle: labelTextStyle,
//                     labelText: "Describe the Event",
//                     hintStyle: labelTextSmallStyle,
//                     hintText: description)),
//           );
//         });
//   }

//   Widget venueField(CreateEventBloc bloc, String venue) {
//     return StreamBuilder<Object>(
//         stream: bloc.venue,
//         builder: (context, snapshot) {
//           return Container(
//               child: TextField(
//             textInputAction: TextInputAction.done,
//             onChanged: bloc.changeVenue,
//             decoration: InputDecoration(
//                 errorText: snapshot.error,
//                 border: UnderlineInputBorder(),
//                 labelStyle: labelTextStyle,
//                 labelText: "Venue of Event",
//                 hintStyle: labelTextSmallStyle,
//                 hintText: venue),
//           ));
//         });
//   }

//   Widget dropDownCategory(CreateEventBloc bloc) {
//     return StreamBuilder<Object>(
//         stream: bloc.category,
//         builder: (context, snapshot) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Select Category",
//                   style: labelTextStyle,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 items: _category.map((String dropDownStringItem) {
//                   return DropdownMenuItem<String>(
//                     child: Text(
//                       dropDownStringItem,
//                       style: labelTextSmallStyle,
//                     ),
//                     value: dropDownStringItem,
//                   );
//                 }).toList(),
//                 onChanged: (String selectedValue) {
//                   setState(() {
//                     _currentSelectedCategory = selectedValue;
//                   });
//                 },
//                 value: _currentSelectedCategory,
//               ),
//             ],
//           );
//         });
//   }

//   Widget dropDownType(CreateEventBloc bloc) {
//     return StreamBuilder<String>(
//         stream: bloc.type,
//         builder: (context, snapshot) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Select Type",
//                   style: labelTextStyle,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 items: _type.map((String dropDownStringItem) {
//                   return DropdownMenuItem<String>(
//                     child: Text(
//                       dropDownStringItem,
//                       style: labelTextSmallStyle,
//                     ),
//                     value: dropDownStringItem,
//                   );
//                 }).toList(),
//                 onChanged: (String selectedValue) {
//                   setState(() {
//                     _currentSelectedType = selectedValue;
//                   });
//                 },
//                 value: _currentSelectedType,
//               ),
//             ],
//           );
//         });
//   }

//   Widget submitButton(CreateEventBloc bloc, EventModel eventData) {
//     return StreamBuilder<Object>(
//         stream: bloc.submitValid,
//         builder: (context, snapshot) {
//           var data = snapshot.data;
//           if (data == null) {
//             data = false;
//           }
//           return AbsorbPointer(
//             absorbing: data ? false : true,
//             child: SoftButton(
//               onClick: () async {
//                 bloc.changeCategory(_currentSelectedCategory);
//                 bloc.changeType(_currentSelectedType);
//                 bloc.changePicture(base64Image);
//                 bloc.changeStartDateTime(startDateLabel + " " + startTimeLabel);
//                 bloc.changeEndDateTime(endDateLabel + " " + endTimeLabel);
//                 await bloc.submit();
//                 Navigator.pop(context);
//               },
//               opacity: data ? true : false,
//               icon: Ionicons.md_checkmark,
//               mainAxisAlignment: MainAxisAlignment.end,
//             ),
//           );
//         });
//   }
// }
