import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  // static const
  static InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(
      width: 2.h,
      color: Colors.grey.shade300,
    ),
  );
  static TextStyle errroStyle = TextStyle(fontSize: 15.sp, color: Colors.red);
  static TextStyle hintStyle = TextStyle(fontSize: 15.sp, color: Colors.grey);
  static TextStyle buttonText =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  static TextStyle settingText = TextStyle(
    fontSize: 15.sp,
    color: Colors.black,
  );

  static ButtonStyle buttonStyle(Color primaryColor) {
    return ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        enableFeedback: true,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(8));
  }
}
