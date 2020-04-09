import 'package:flutter/material.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../../widgets/Order/order_card.dart';

class OrderScreen extends StatefulWidget {
  final int eventId;

  OrderScreen({this.eventId});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Widget build(BuildContext context) {
    final bloc = GetOrderBlocProvider.of(context);
    bloc.getIds(widget.eventId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text(
            'Orders',
          ),
          elevation: 0,
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 230, child: OrderCard()),
    );
  }
}
