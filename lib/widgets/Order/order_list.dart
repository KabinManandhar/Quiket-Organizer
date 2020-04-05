import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/Order/getOrderBlocProvider.dart';
import 'package:testawwpp/models/order_model.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../../control/style.dart';
import '../../models/ticket_model.dart';
import '../loadingTicketContainer.dart';

class OrderList extends StatelessWidget {
  final int orderId;

  OrderList({this.orderId});

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
            return buildTile(context, orderSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, OrderModel order) {
    print("VALUES");
    print(order.status);
    print(order.userId);
    print(order.id);
    print(order.ticketId);
    print(order.qrCode);
    print("VALUES");
    if (order.status == null && order.id == null) {
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
          onTap: () {
            print("${order.ticketId}");
          },
          title: Text(
            order.qrCode,
            style: labelTextStyle,
          ),
          subtitle: Text(order.status == 0 ? "Not on Sale" : "On Sale"),
          trailing: Text(
            order.status == 0 ? 'Free' : 'Rs.${order.userId}',
            style: labelTextStyle,
          ),
        ),
        Divider(
          height: 8,
        ),
      ],
    );
  }
}
