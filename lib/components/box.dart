import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class Boxy extends StatelessWidget {
  const Boxy({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 74.h,
          width: 74.h,
          decoration: BoxDecoration(
            color: Constants.creamColor,
            borderRadius: BorderRadius.circular(10.r),
            // boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/$image.svg",
                fit: BoxFit.cover,
                height: 40.h,
                width: 40.h,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w500,

            // fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
