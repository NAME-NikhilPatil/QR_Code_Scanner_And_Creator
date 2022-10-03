import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SaveWebsite extends StatefulWidget {
  SaveWebsite({super.key, this.dataString});

  String? dataString;
  @override
  State<SaveWebsite> createState() => _SaveWebsiteState();
}

class _SaveWebsiteState extends State<SaveWebsite> {
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
          '$directory/${DateTime.now()}${ref.qrData!}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          await ref.createQr(ref.qrData!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
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
            OutlinedButton(
              child: const Text("Save"),
              onPressed: () => takeScreenShot(widget.dataString),
            ),
          ],
        ),
      ),
    );
  }
}
