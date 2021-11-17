import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:limuny/ui/place/checkin_confirmation_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:limuny/styles/theme.dart' as Style;

class CheckInScanner extends StatefulWidget {
  const CheckInScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckInScannerScanner();
}

class _CheckInScannerScanner extends State<CheckInScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      return ConfirmationPlaceScreen(uuid: result!.code);
      // return Scaffold(
      //   backgroundColor: Style.Colors.colorWhite,
      //   body: SafeArea(
      //     child: Padding(
      //       padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      //             child: Row(
      //               mainAxisSize: MainAxisSize.max,
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               children: [
      //                 Card(
      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
      //                   color: Style.Colors.mainColor,
      //                   elevation: 2,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(40),
      //                   ),
      //                   child: IconButton(
      //                     // borderColor: Colors.transparent,
      //                     // borderRadius: 30,
      //                     // buttonSize: 46,
      //                     icon: Icon(
      //                       Icons.close_rounded,
      //                       color: Colors.white,
      //                       size: 20,
      //                     ),
      //                     onPressed: () async {
      //                       Navigator.pop(context);
      //                     },
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      //             child: Card(
      //               clipBehavior: Clip.antiAliasWithSaveLayer,
      //               color: Style.Colors.mainColor,
      //               elevation: 3,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(70),
      //               ),
      //               child: Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
      //                 child: Icon(
      //                   Icons.check_rounded,
      //                   color: Colors.white,
      //                   size: 60,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      //             child: Text(
      //               'Data has been received!',
      //               style: TextStyle(
      //                 fontFamily: 'Lexend Deca',
      //                 color: Style.Colors.mainColor,
      //                 fontSize: 24,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
      //             child: Text(
      //               'Please go to confirmation page to check-in Location, Don\'t Forget to Wear a Mask, Keep Social Distancing',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontFamily: 'Lexend Deca',
      //                 color: Color(0xFF8B97A2),
      //                 fontSize: 14,
      //                 fontWeight: FontWeight.normal,
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
      );
    }
    return Scaffold();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
