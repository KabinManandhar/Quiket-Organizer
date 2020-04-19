import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../../control/style.dart';
import '../../resources/OrderApiProvider.dart';
import '../../resources/requests.dart';
import '../../resources/secureStorage.dart';
import '../../widgets/loadingTicketContainer.dart';
import '../../widgets/softButton.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";

class ScannerScreen extends StatefulWidget {
  final int eventId;

  ScannerScreen({
    this.eventId,
    Key key,
  }) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  var qrText = "";
  var flashState = flash_on;
  var cameraState = front_camera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final bloc = GetOrderBlocProvider.of(context);
    bloc.getIds(widget.eventId);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 110,
        child: Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.grey[300],
                  // borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
              flex: 6,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: SoftButton(
                            onClick: () {
                              if (controller != null) {
                                controller.toggleFlash();
                                if (_isFlashOn(flashState)) {
                                  setState(() {
                                    flashState = flash_off;
                                    controller?.resumeCamera();
                                  });
                                } else {
                                  setState(() {
                                    flashState = flash_on;
                                    controller?.resumeCamera();
                                  });
                                }
                              }
                            },
                            icon: SimpleLineIcons.bulb,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: SoftButton(
                              onClick: () {
                                controller?.resumeCamera();
                              },
                              icon: Ionicons.ios_qr_scanner),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: SoftButton(
                            onClick: () {
                              controller?.pauseCamera();
                            },
                            icon: SimpleLineIcons.control_pause,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  _onQrRead(),
                ],
              ),
              height: 140,
            ),
          ],
        ),
      ),
    );
  }

  _isFlashOn(String current) {
    return flash_on == current;
  }

  Widget _onQrRead() {
    if (qrText.isEmpty) {
      return LoadingTicketContainer();
    } else if (qrText.isNotEmpty) {
      controller.pauseCamera();
      return Expanded(
        child: SizedBox(height: 140, child: _qrCheck(qrText)),
      );
    } else {
      return Container(
        color: Colors.blue,
        height: 140,
      );
    }
  }

  Widget _qrCheck(qrCode) {
    print('TEST');
    return FutureBuilder(
        future: OrderApiProvider().checkQr(qrCode),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var check = snapshot.data;

            if (check['success']) {
              checkIn(qrCode, check['id']);
              return Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      MaterialCommunityIcons.checkbox_marked_circle_outline,
                      color: Colors.green,
                      size: 70,
                    ),
                    Text(
                      'Successfully Checked In.',
                      style: labelTextStyle,
                    ),
                  ],
                ),
              );
            } else if (check['error'] == true) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      MaterialCommunityIcons.close_circle_outline,
                      color: Colors.red,
                      size: 70,
                    ),
                    Text(
                      'Invalid QR Code. This QR code does not exist in the system',
                      style: labelTextStyle,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                  child: Column(
                children: <Widget>[
                  Icon(
                    MaterialCommunityIcons.close_circle_outline,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text(
                    'Already Checked In. Duplicate Entry Found.',
                    style: labelTextStyle,
                  ),
                ],
              ));
            }
          } else {
            return Container();
          }
        });
  }

  checkIn(qrCode, id) async {
    String token = await secureStorage.read(key: 'token');
    Map<String, dynamic> data = {'status': 1};
    await req.putRequest(data, '/orders/$id', token);
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
