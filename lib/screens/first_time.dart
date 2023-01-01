import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:qr_code_scan/components/bottom_navigation.dart';
import 'package:qr_code_scan/rate_app_init.dart';
import 'package:qr_code_scan/screens/splash_screen.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../Provider/scan_data.dart';
import '../Provider/saved_setting.dart';

class FirstTime extends StatefulWidget {
  const FirstTime({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstTime> createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  late bool isgranted;
  @override
  void initState() {
    super.initState();

    isgranted = SaveSetting.getgranted() ?? false;
    // Provider.of<ScanData>(context, listen: false).isgranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isgranted == true ? MyNavigationBar() : SplashScreen(),
    );
  }
}
