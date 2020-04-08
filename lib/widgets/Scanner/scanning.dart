import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testawwpp/resources/requests.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../../control/style.dart';
import '../../models/order_model.dart';
import '../loadingTicketContainer.dart';

class Scanning extends StatelessWidget {
  final int orderId;
  final qrData;

  Scanning({this.orderId, this.qrData});

  Widget build(context) {
    final bloc = GetOrderBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.orders,
      builder: (context, AsyncSnapshot<Map<int, Future<OrderModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTicketContainer();
        }

        return FutureBuilder(
          future: snapshot.data[orderId],
          builder: (context, AsyncSnapshot<OrderModel> orderSnapshot) {
            if (!orderSnapshot.hasData) {
              return LoadingTicketContainer();
            }
            return buildTile(context, orderSnapshot.data, qrData);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, OrderModel order, qrData) {
    print(order);
    if (order.status == null && order.id == null) {
      return Column(
        children: <Widget>[
          LoadingTicketContainer(),
        ],
      );
    }
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print(qrData);
    print(order.qrCode);
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");
    print("WHAIHOIWHOITAHWOWAITHWAOIAWHTOAWITHWAOTIWAHTWOAITHWAOTWIAHT");

    if (qrData == order.qrCode) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async {
              String token = await secureStorage.read(key: 'token');
              int stat = order.status;
              int value;
              if (stat == 0) {
                value = 1;
              } else {
                value = 0;
              }
              Map<String, dynamic> data = {'status': value};
              var result =
                  await req.putRequest(data, '/orders/${order.id}', token);
              print(result.body);
            },
            title: Text(
              order.userName,
              style: labelTextStyle,
            ),
            subtitle: Text(order.ticketName),
            trailing: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: order.status == 0 ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Divider(
            height: 8,
          ),
        ],
      );
    } else {
      Text(
        'Invalid QR Code. Sorry.',
        style: labelTextStyle,
      );
    }
  }
}
