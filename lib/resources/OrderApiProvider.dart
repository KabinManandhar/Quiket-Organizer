import 'dart:convert';

import '../models/order_model.dart';
import 'requests.dart';
import 'secureStorage.dart';

class OrderApiProvider {
  final _rootUrl = '/events';
  final _ordUrl = '/orders';
  String _token;

  Future<List<int>> getOrdersId(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');
      final response =
          await req.authGetRequest(_rootUrl + "/$id" + _ordUrl, _token);
      final ids = json.decode(response.body);

      return ids.cast<int>();
    } catch (e) {
      return null;
    }
  }

  Future<OrderModel> getOrder(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');
      final response = await req.authGetRequest(_ordUrl + '/$id', _token);
      final order = json.decode(response.body);
      return OrderModel.fromJson(order[0]);
    } catch (e) {
      return null;
    }
  }

  getOrderCount(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');
      final response = await req.authGetRequest(
          _rootUrl + "/$id" + _ordUrl + 'Count', _token);
      final order = json.decode(response.body);
      return order;
    } catch (e) {
      return null;
    }
  }

  checkQr(String qrCode) async {
    Map<String, dynamic> data = {'qr_code': qrCode};
    _token = await secureStorage.read(key: 'token');

    final response =
        await req.authPostRequest(data, _ordUrl + '/check', _token);
    final check = json.decode(response);
    return check;

    // if (check['error'] != null) {
    //   return 1;
    // } else {
    //   if (check['success']) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
  }
}
