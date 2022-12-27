import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class SaveQrCode extends StatefulWidget {
  SaveQrCode({super.key, this.dataString, this.formate});

  String? dataString;
  String? formate;
  @override
  State<SaveQrCode> createState() => _SaveQrCodeState();
}

class _SaveQrCodeState extends State<SaveQrCode> {
  GlobalKey globalKey = GlobalKey();

  bool permission = true;

  takeScreenShot(ref) async {
    PermissionStatus res;
    res = await Permission.storage.request();

    if (res.isGranted) {
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 5.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getExternalStorageDirectory();
      final file =
          await File('${tempDir!.path}/${DateTime.now().microsecond}${ref}.png')
              .create(recursive: true);
      await file.writeAsBytes(pngBytes);
      GallerySaver.saveImage(file.path);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Saved to Gallery"),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (res.isDenied) {
      Alert(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        closeIcon: SizedBox(),
        context: context,
        type: AlertType.none,
        content: SizedBox(
            child: Text(
          "We need storage permission for storing qr code",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
        )),
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.blue,
          )
        ],
      ).show();
    } else if (res.isPermanentlyDenied) {
      permission = false;
      Alert(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        closeIcon: SizedBox(),
        context: context,
        type: AlertType.none,
        content: Center(
          child: Text(
            "Open app info and enable storage permission",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15.sp,
            ),
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            onPressed: () {
              openAppSettings();
            },
            color: Colors.blue,
          )
        ],
      ).show();
    }
  }

  int originalSize = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.r,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.formate == null
                            ? ""
                            : widget.formate.toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.dataString!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      RepaintBoundary(
                        key: globalKey,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 20.w),
                          child: QrImage(
                            data: widget.dataString!,

                            // data:abid,  uid,  txnid,

                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            version: QrVersions.auto,
                            size: 200.h,
                            gapless: true,
                            embeddedImage:
                                const AssetImage('assets/img/qr.png'),
                            embeddedImageStyle: QrEmbeddedImageStyle(
                              size: const Size(70, 70),
                            ),
                          ),
                        ),
                      ),
                      //     ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0.r),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                // : MaterialStateProperty.all<Color>(Colors.grey),
                                enableFeedback: true,
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 50.w, vertical: 10.h))),
                            onPressed: () {
                              setState(() {
                                takeScreenShot(widget.dataString);
                              });
                            },
                            child: const Text('Save'),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0.r),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                enableFeedback: true,
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 50.w, vertical: 10.h))),
                            onPressed: () async {
                              // share(widget.dataString);
                              // ShareFilesAndScreenshotWidgets()
                              //     .takeScreenshot(globalKey, originalSize)
                              //     .then(
                              //   (Image? value) {
                              //     setState(() {
                              //       _image = value;
                              //     });
                              //   },
                              // );
                              ShareFilesAndScreenshotWidgets().shareScreenshot(
                                  globalKey,
                                  originalSize,
                                  "Title",
                                  "Name.png",
                                  "image/png",
                                  text:
                                      "This qr code is generated by this app");
                            },
                            child: const Text('Share'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
