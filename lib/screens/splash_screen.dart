import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/saved_setting.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/components/bottom_navigation.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
  }) : super(key: key);
  // RateMyApp rateMyApp;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  permissionServiceCall() async {
    await permissionServices().then(
      (value) {
        if (value != null) {
          if (value[Permission.camera]!.isGranted) {
            /* ========= New Screen Added  ============= */
            setState(() {
              Provider.of<ScanData>(context, listen: false).isgranted = true;
              SaveSetting.granted(true);
            });

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyNavigationBar()));
          }
        }
      },
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.camera]!.isPermanentlyDenied) {
      setState(() async {
        Provider.of<ScanData>(context, listen: false).isgranted = false;

        SaveSetting.granted(false);
        await Alertx(context);
      });
      // if (statuses[Permission.camera]!.isGranted) {
      //   runApp(MyApp());
      // }
      //  else {}
    } else {
      if (statuses[Permission.camera]!.isDenied) {
        setState(() {
          Alertt(context);
          Provider.of<ScanData>(context, listen: false).isgranted = false;

          SaveSetting.granted(false);
        });

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("App needs camera permission for scanning"),
        //   behavior: SnackBarBehavior.floating,
        // ));
        // Timer.periodic(const Duration(seconds: 10), (Timer t) {
        //   setState(() {
        //     permissionServiceCall();
        //     t.cancel();
        //   });
        // });
      }
    }
    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  Alertx(context) {
    Alert(
      onWillPopActive: true,

      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      closeIcon: SizedBox(),
      context: context,
      style: AlertStyle(
        backgroundColor: Constants.creamColor,
      ),
      type: AlertType.none,
      // title: "Permission",
      content: Text(
        "Please go to App info and unable camera permission",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 15.sp,
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            // setState(() {
            //   Provider.of<ScanData>(context, listen: false).isgranted = true;
            // });
            Provider.of<ScanData>(context, listen: false).open = true;
            openAppSettings();
          },
          color: Constants.primaryColor,
        )
      ],
    ).show();
  }

  Alertt(context) {
    Alert(
      onWillPopActive: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      closeIcon: SizedBox(),
      context: context,
      style: AlertStyle(
        backgroundColor: Constants.creamColor,
      ),
      type: AlertType.none,

      // title: "Permission",
      content: Text(
        "We need camera permission for scanning Qrcodes or Barcodes",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 15.sp,
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            // openAppSettings();
            permissionServiceCall();
            Navigator.pop(context);
          },
          color: Constants.primaryColor,
        )
      ],
    ).show();
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyNavigationBar()));
      permissionServiceCall();
    });
  }

  Widget _buildImage(String assetName) {
    return SvgPicture.asset('assets/$assetName', width: 200.w, height: 200.w);
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = TextStyle(
      fontSize: 19.0.sp,
    );

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0.sp,
        fontWeight: FontWeight.w700,
        color: Constants.primaryColor,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.h, 16.0.w),
      pageColor: Constants.creamColor,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Constants.creamColor,
        autoScrollDuration: 7000,
        pages: [
          PageViewModel(
            title: "Fast and Accurate",
            body: "Scan, Decode, and Explore the World Around You",
            image: _buildImage('1.svg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Create QR codes",
            body:
                "Create QR codes that link to websites, social media profiles, and more",
            image: _buildImage('2.svg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Scanning History",
            body:
                "The app keeps a record of all the QR codes that have been scanned",
            image: _buildImage('3.svg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Automatic scanning",
            body:
                "App can automatically detect and scan QR codes or barcodes using AI",
            image: _buildImage('4.svg'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        skip: Text(
          "Skip",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        skipStyle: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(Constants.primaryColor),
        ),
        next: Text(
          "Next",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Constants.creamColor,
          ),
        ),
        nextStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Constants.primaryColor),
            enableFeedback: true,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h))),
        done: Text(
          "Scan Now",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Constants.creamColor,
          ),
        ),
        doneStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Constants.primaryColor),
          enableFeedback: true,
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
          ),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: EdgeInsets.only(bottom: 15.h),
        dotsDecorator: DotsDecorator(
          activeColor: Constants.primaryColor,
          size: Size(10.0.w, 10.0.w),
          color: const Color(0xFFBDBDBD),
          activeSize: Size(22.0.w, 10.0.w),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
