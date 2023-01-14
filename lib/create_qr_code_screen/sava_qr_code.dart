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
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import '../constants.dart';

// ignore: must_be_immutable
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
      // ignore: use_build_context_synchronously
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 5.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getExternalStorageDirectory();
      final file =
          await File('${tempDir!.path}/${DateTime.now().microsecond}$ref.png')
              .create(recursive: true);
      await file.writeAsBytes(pngBytes);
      GallerySaver.saveImage(file.path);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Saved to Gallery",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Constants.primaryColor,
      ));
    } else if (res.isDenied) {
      Alert(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        closeIcon: const SizedBox(),
        context: context,
        style: const AlertStyle(
          backgroundColor: Colors.white,
        ),
        type: AlertType.none,
        content: SizedBox(
            child: Text(
          "We need storage permission for storing Qrcode",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 15.sp,
          ),
        )),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Constants.primaryColor,
            child: Text(
              "Ok",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          )
        ],
      ).show();
    } else if (res.isPermanentlyDenied) {
      permission = false;
      Alert(
        // onWillPopActive: true,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        closeIcon: const SizedBox(),
        context: context,
        style: const AlertStyle(
          backgroundColor: Colors.white,
        ),
        type: AlertType.none,
        content: Center(
          child: Text(
            "Please open app info and enable storage permission",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 15.sp,
            ),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            color: Constants.primaryColor,
            child: Text(
              "Ok",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          )
        ],
      ).show();
    }
  }

  int originalSize = 2000;

  String playStoreId = "com.example.qr_code_scanner";
  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        googlePlayIdentifier: playStoreId,
        minDays: 0,
        minLaunches: 3,
        remindDays: 1,
        remindLaunches: 2,
      ),
      onInitialized: (context, rateMyApp) {
        setState(() {
          rateMyApp = rateMyApp;
        });
        Widget buildOkButton(double star) {
          return TextButton(
              onPressed: () async {
                const event = RateMyAppEventType.rateButtonPressed;
                await rateMyApp.callEvent(event);
                final launchAppStore = star >= 4;
                if (launchAppStore) {
                  rateMyApp.launchStore();
                }
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Constants.primaryColor,
                  content: const Text(
                    "Thanks for your feedback 😊",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                ));

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text("OK"));
        }

        Widget buildCancelButton() {
          return RateMyAppNoButton(rateMyApp, text: "CANCEL");
        }

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showStarRateDialog(
            context,
            title: "Rate This App 😊",
            message:
                "Your feedback helps us to improve the app and provide a better experience for all of our users",
            starRatingOptions: const StarRatingOptions(initialRating: 4),
            actionsBuilder: (BuildContext context, double? stars) {
              return stars == null
                  ? [buildCancelButton()]
                  : [buildOkButton(stars), buildCancelButton()];
            },
          );
        }
      },
      builder: (context) => Scaffold(
        backgroundColor: Constants.creamColor,
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
                        color: Colors.grey.shade300,
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
                            : widget.formate.toString().replaceFirst(
                                widget.formate![0],
                                widget.formate![0].toUpperCase()),
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
                          fontSize: 18.sp,
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
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Constants.primaryColor,
                              ),
                              enableFeedback: true,
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          horizontal: 50.w, vertical: 15.h)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  takeScreenShot(widget.dataString);
                                },
                              );
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Constants.primaryColor),
                              enableFeedback: true,
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          horizontal: 50.w, vertical: 15.h)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              ShareFilesAndScreenshotWidgets().shareScreenshot(
                                globalKey,
                                originalSize,
                                "Title",
                                "Name.png",
                                "image/png",
                              );
                            },
                            child: Text(
                              'Share',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
