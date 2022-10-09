import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SaveQrCode extends StatefulWidget {
  SaveQrCode({super.key, this.dataString});

  String? dataString;
  @override
  State<SaveQrCode> createState() => _SaveQrCodeState();
}

class _SaveQrCodeState extends State<SaveQrCode> {
  GlobalKey globalKey = GlobalKey();

  takeScreenShot(ref) async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateTime.now()}${ref}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Saved to Gallery")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Center(
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  color: Colors.white,
                  child: QrImage(
                    data: widget.dataString!,
                    // data:abid,  uid,  txnid,
                    version: QrVersions.auto,
                    size: 200,
                    gapless: false,
                    embeddedImage: const AssetImage('assets/img/logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(70, 70),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  // : MaterialStateProperty.all<Color>(Colors.grey),
                  enableFeedback: true,
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h))),
              onPressed: () {
                setState(
                  () {
                    takeScreenShot(widget.dataString);
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
