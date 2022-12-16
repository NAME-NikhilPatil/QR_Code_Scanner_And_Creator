import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/components/bottom_navigation.dart';
import 'package:qr_code_scan/model/saved_setting.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

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

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyNavigationBar()));
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
      setState(() {
        setState(() {
          Alertx(context);
          Provider.of<ScanData>(context, listen: false).isgranted = false;

          SaveSetting.granted(false);
        });
      });
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
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      closeIcon: SizedBox(),
      context: context,
      style: AlertStyle(),
      type: AlertType.none,
      title: "Permission",
      content: Text(
        "Go to App setting and unable camera permission",
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
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            openAppSettings().then(
              (value) async {
                if (value) {
                  if (await Permission.camera.status.isPermanentlyDenied ==
                          true &&
                      await Permission.camera.status.isGranted == false) {
                    // Timer.periodic(const Duration(seconds: 5), (Timer t) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text("Unable camera permision in app setting"),
                    //     behavior: SnackBarBehavior.floating,
                    //   ));
                    // });

                    // permissionServiceCall(); /* opens app settings until permission is granted */
                  }
                }
              },
            );
            // permissionServiceCall();
            Navigator.pop(context);
          },
          color: Colors.blue,
        )
      ],
    ).show();
  }

  Alertt(context) {
    Alert(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      closeIcon: SizedBox(),
      context: context,
      style: AlertStyle(),
      type: AlertType.none,
      title: "Permission",
      content: Text(
        "Need camera permission to scan QR code or barcode",
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
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            // openAppSettings();
            permissionServiceCall();
            Navigator.pop(context);
          },
          color: Colors.blue,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyNavigationBar()));
            permissionServiceCall();
          },
          child: Text("Go to next page "),
        ),
      ),
    );
  }
}
