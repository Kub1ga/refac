import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(Color color, Widget widget) {
  return Container(
    height: 60.h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(
        100.r,
      ),
    ),
    child: Center(
      child: widget
    ),
  );
}
