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
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          title: Text(
            'Orders ${widget.eventId}',
          ),
          elevation: 0,
        ),
      ),
      body: OrderCard(),
    );
  }
}
