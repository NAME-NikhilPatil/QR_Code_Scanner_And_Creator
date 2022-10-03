import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scan/screens/result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final qrKey = GlobalKey(debugLabel: "Qr");

  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  done(BuildContext context) async {
    if (barcode != null) {
      //  await
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ScanResult(
      //       barcode: barcode!.code.toString(),
      //     ),
      //   ),
      // );
     await Future.delayed(Duration.zero, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResult(
              barcode: barcode!.code.toString(),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (barcode != null) done(context),
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

  Widget buildResult() {
    return TextButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Text(
          barcode != null ? "Resutl ${barcode!.code}" : "scan a code",
          maxLines: 3,
        ),
      ),
    );
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
      }),
    );
  }
}
