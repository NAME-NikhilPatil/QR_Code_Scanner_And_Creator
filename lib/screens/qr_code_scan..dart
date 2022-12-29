import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import 'package:qr_code_scan/screens/result.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:vibration/vibration.dart';
import '../Provider/scan_data.dart';
import '../components/bottom_navigation.dart';
import '../model/history.dart';
import '../model/saved_setting.dart';
import 'exit.dart';

class QrScanScreen extends StatefulWidget {
  QrScanScreen({
    Key? key,
  }) : super(key: key);
  @override
  _QrScanScreenState createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen>
    with WidgetsBindingObserver {
  late MobileScannerController controller;
  RateMyApp? rateMyApp;

  String? barcode;
  late List<History> historyi = [];
  late Box<History> historyBox;
  bool isStarted = true;
  late bool isVibrate;
  late bool isgranted;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    isgranted = SaveSetting.getgranted() ?? false;
    historyBox = Hive.box('history');
    controller = MobileScannerController();
    isVibrate = SaveSetting.getVibrate() ?? true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final granted = await Permission.camera.isGranted;
    var permission = Provider.of<ScanData>(context, listen: false).open;
    if (state == AppLifecycleState.resumed && granted && permission == true) {
      SaveSetting.granted(true);
      permission = false;
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => MyNavigationBar())));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isEnabled = true;
  // Future<void> restart() async {
  //   // await controller.stop();
  //   await controller.start();
  // }

  onDetect(String barcode, MobileScannerArguments? _, String formate) {
    isEnabled = false;
    isVibrate == true ? Vibration.vibrate(duration: 100) : null;

    setState(() {
      var historyDb = Provider.of<ScanData>(context, listen: false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResult(
            barcode: barcode,
            formate: formate,
          ),
        ),
      );

      historyDb.addItem(
        History(barcode.toString(), formate),
      );
    });
  }

  String playStoreId = "com.example.qr_code_scanner";

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 250.h,
      height: 250.h,
    );

    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        googlePlayIdentifier: playStoreId,
        minDays: 0,
        minLaunches: 4,
        remindLaunches: 4,
        remindDays: 1,
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

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    "Thanks for your feedback",
                  ),
                  behavior: SnackBarBehavior.floating,
                ));

                Navigator.pop(context);
              },
              child: Text("OK"));
        }

        Widget buildCancelButton() {
          return RateMyAppNoButton(rateMyApp, text: "CANCEL");
        }

        if (rateMyApp.shouldOpenDialog) {
          // rateMyApp.showRateDialog(context);
          rateMyApp.showStarRateDialog(
            context,
            title: "Rate This App",
            message: "Do you like this app?Please leave a rating",
            starRatingOptions: StarRatingOptions(initialRating: 4),
            actionsBuilder: (BuildContext context, double? stars) {
              return stars == null
                  ? [buildCancelButton()]
                  : [buildOkButton(stars), buildCancelButton()];
            },
          );
        }
      },
      builder: (context) => WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Builder(
            builder: (context) {
              return Stack(fit: StackFit.expand, children: [
                MobileScanner(
                  allowDuplicates: false,
                  fit: BoxFit.cover,
                  scanWindow: scanWindow,
                  controller: controller,
                  onDetect: (barcode, args) => isEnabled
                      ? onDetect(barcode.rawValue.toString(), args,
                          barcode.type.name.toString())
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.zero, //widget.overlayMargin,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: QrScannerOverlayShape(
                        borderRadius: 0.r,
                        borderColor: Colors.white,
                        borderLength: 18.w,
                        borderWidth: 9.w,
                        cutOutHeight: 0.7.sw,
                        cutOutWidth: 0.7.sw,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.1.sh,
                    ),
                    Text(
                      "QRSCANNER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.w),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                  color: Colors.white,
                                  icon: ValueListenableBuilder(
                                    valueListenable: controller.torchState,
                                    builder: (context, state, child) {
                                      if (state == null) {
                                        return const Icon(
                                          MdiIcons.flashlight,
                                          color: Colors.white,
                                        );
                                      }
                                      switch (state as TorchState) {
                                        case TorchState.off:
                                          return const Icon(
                                            MdiIcons.flashlight,
                                            color: Colors.white,
                                          );
                                        case TorchState.on:
                                          return const Icon(
                                            Icons.flashlight_on,
                                            color: Colors.yellow,
                                          );
                                      }
                                    },
                                  ),
                                  iconSize: 30.0,
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    controller.toggleTorch();
                                    isVibrate == true
                                        ? Vibration.vibrate(duration: 100)
                                        : null;
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.w),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.image),
                                iconSize: 25.0,
                                onPressed: () async {
                                  isVibrate == true
                                      ? Vibration.vibrate(duration: 100)
                                      : null;

                                  final ImagePicker picker = ImagePicker();
                                  // Pick an image
                                  final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image != null) {
                                    if (await controller
                                        .analyzeImage(image.path)) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Barcode found!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('No barcode found!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                  ],
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    // this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 120),
    this.borderRadius = 0,
    this.borderLength = 40.0,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  })  : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
        cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
      borderLength <=
          min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert(
        (cutOutWidth == null && cutOutHeight == null) ||
            (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
        'Use only cutOutWidth and cutOutHeight or only cutOutSize');
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final _borderLength =
        borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
            ? borderWidthSize / 2
            : borderLength;
    final _cutOutWidth =
        cutOutWidth < width ? cutOutWidth : width - borderOffset;
    final _cutOutHeight =
        cutOutHeight < height ? cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - _cutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          _cutOutHeight / 2 +
          borderOffset,
      _cutOutWidth - borderOffset * 2,
      _cutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - _borderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + _borderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + _borderLength,
          cutOutRect.top + _borderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - _borderLength,
          cutOutRect.bottom - _borderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - _borderLength,
          cutOutRect.left + _borderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
