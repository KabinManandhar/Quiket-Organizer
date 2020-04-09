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
    List<Widget> error = List<Widget>();
    int counter = 0;

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
            if (orderSnapshot.data.qrCode == qrData) {
              return buildTile(context, orderSnapshot.data, qrData);
            } else {
              return Center(
                child: Container(
                  height: 140,
                  child: Text(
                    "Invalid Ticket",
                    style: labelTextStyle,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, OrderModel order, qrData) {
    if (order.qrCode.isEmpty && order.status == null && order.id == null) {
      return Column(
        children: <Widget>[
          LoadingTicketContainer(),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () async {},
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
          height: 40,
        ),
      ],
    );
  }
}
