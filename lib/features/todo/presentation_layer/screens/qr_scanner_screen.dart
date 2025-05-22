import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  bool isScanning = true;

  @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (isScanning) {
  //       isScanning = false;
  //       Navigator.pop(context, scanData.code);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مسح QR Code')),
      body: MobileScanner(),
      // body: QRView(
      //   key: qrKey,
      //   onQRViewCreated: _onQRViewCreated,
      //   overlay: QrScannerOverlayShape(
      //     borderColor: Colors.purple,
      //     borderRadius: 10,
      //     borderLength: 30,
      //     borderWidth: 10,
      //   ),
      // ),
    );
  }
}
