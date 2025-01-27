import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../refresh.dart';
import 'order_list.dart';

class OrderCard extends StatefulWidget {
  final eventId;

  const OrderCard({Key key, this.eventId}) : super(key: key);
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with AutomaticKeepAliveClientMixin<OrderCard> {
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
        return Refresh(
          eventId: widget.eventId,
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.getOrder(snapshot.data[index]);
                return OrderList(orderId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
