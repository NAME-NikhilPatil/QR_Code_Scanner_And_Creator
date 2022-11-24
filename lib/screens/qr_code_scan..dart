import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/screens/result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../model/history.dart';

class QrCodeScan extends StatefulWidget {
  const QrCodeScan({Key? key}) : super(key: key);

  @override
  State<QrCodeScan> createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  final qrKey = GlobalKey(debugLabel: "Qr");
  late List<History> historyi = [];
  late Box<History> historyBox;
  QRViewController? controller;
  Barcode? barcode;
  final picker = ImagePicker();
  String _qrcodeFile = '';
  String _data = '';

  void readQr() async {
    if (barcode != null) {
      controller!.pauseCamera();
      print(barcode!.code);
      controller!.dispose();
    }
  }

  @override
  void initState() {
    historyBox = Hive.box('history');
    print(historyBox.values);

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildQrView(context),

              Positioned(
                  top: 52.h,
                  child: const Text(
                    "QR CODE SCANNER",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            

              Positioned(
                bottom: 30.h,
                child: buildControllerButton(),
              ),
              // if (barcode != null)
              //   done(context, barcode!.code.toString())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildControllerButton() {
    return Row(children: [
      Container(
        height: 60.h,
        width: 100.w,
        margin: EdgeInsets.all(25.w),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: ((context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white70,
                    );
                  } else {
                    return Container();
                  }
                }))),
      ),
      Container(
        height: 60.h,
        width: 100.w,
        margin: EdgeInsets.all(25.w),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: ((context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(
                      Icons.switch_camera,
                      color: Colors.white70,
                    );
                  } else {
                    return Container();
                  }
                }))),
      ),
    ]);
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: 263.h,
        borderWidth: 15.h,
        borderLength: 20.h,
        borderRadius: 10.r,
        borderColor: Colors.white,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (barcode) => setState(() {
        this.barcode = barcode;
        var historyDb = Provider.of<ScanData>(context, listen: false);
        historyDb.addItem(History(barcode.code.toString()));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResult(
              barcode: barcode.code.toString(),
            ),
          ),
        );
      }),
    );
    controller.pauseCamera();
    controller.resumeCamera();
  }

 
}
