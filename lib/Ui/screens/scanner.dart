import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:testawwpp/widgets/Scanner/order_scans.dart';
import 'package:testawwpp/widgets/softButton.dart';

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
                                  });
                                } else {
                                  setState(() {
                                    flashState = flash_on;
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
                              controller?.pauseCamera();
                            },
                            icon: SimpleLineIcons.control_pause,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: SoftButton(
                              onClick: () {
                                controller?.resumeCamera();
                              },
                              icon: SimpleLineIcons.control_play),
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
                  Text(qrText),
                  OrderScans(
                    qrData: qrText,
                  ),
                ],
              ),
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  _isFlashOn(String current) {
    return flash_on == current;
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
