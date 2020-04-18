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
