import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child:  Text("SCAN QR CODE",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color:  Color(0xff000000),
                    )),

              ),
              LottieBuilder.asset(
                "assets/qr-scanner.json",
                height: height * 0.2,
                fit: BoxFit.fitHeight,
              ),

              SizedBox(height: height*0.03,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: height*0.3,
                    width: height*0.3,
                    child: QRView(
                      key: _key,
                      onQRViewCreated: qr,

                    )
                  ),
                ),
              ),
              SizedBox(height: height*0.05,),
              result != null ? Text("${result!.code}",style: Theme.of(context).textTheme.titleLarge) : const Text("",style: TextStyle(color: Colors.green,fontSize: 20),),
            ],
          ),
        ),
      )
    );
  }
}
