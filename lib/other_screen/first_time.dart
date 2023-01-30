import "package:flutter/material.dart";
import 'package:qr_code_scan/components/bottom_navigation.dart';
import 'package:qr_code_scan/other_screen/splash_screen.dart';
import '../providers/saved_setting.dart';

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
    try {
      isgranted = SaveSetting.getgranted() ?? false;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isgranted == true ? const MyNavigationBar() : const SplashScreen(),
    );
  }
}
