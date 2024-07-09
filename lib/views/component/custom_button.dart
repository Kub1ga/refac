import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(Color color, String text) {
  return Container(
    height: 60.h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(
        100.r,
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white
        ),
      ),
    ),
  );
}
