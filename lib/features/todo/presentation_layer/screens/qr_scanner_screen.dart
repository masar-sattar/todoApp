// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:todo_app/features/todo/presentation_layer/screens/details_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // final MobileScannerController controller = MobileScannerController();

  bool isScanning = true;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مسح QR Code')),
      body: MobileScanner(
        // controller: controller,
        onDetect: (BarcodeCapture capture) {
          if (!isScanning) return;

          final String? code = capture.barcodes.first.rawValue;
          if (code != null) {
            // setState(() => isScanning = true);
            print("✅ تم قراءة QR: $code");
            Navigator.pop(context);
            Navigator.push<String>(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(id: code)));
          } else {
            print(' لم يتم قراءة الكود');
          }
        },
      ),
    );
  }
}
