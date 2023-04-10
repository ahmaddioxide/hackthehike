import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  GlobalKey _key = GlobalKey();
  QRViewController? controller;
  Barcode? result;

  void qr(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: height*0.3,
                  width: height*0.3,
                  child: QRView(
                    key: _key,
                    onQRViewCreated: qr,

                  )
                ),
              ),
            ),
            SizedBox(height: height*0.1,),
            result != null ? Text("${result!.code}",style: Theme.of(context).textTheme.titleLarge) : Text("Scan the QR Code",style: Theme.of(context).textTheme.titleLarge,)
          ],
        ),
      )
    );
  }
}
