import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
              color: Colors.grey, borderRadius: BorderRadius.circular(15.r)),
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
          style: const TextStyle(
            color: Colors.black,

            // fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
