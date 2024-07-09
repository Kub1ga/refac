import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customIconForm(Icon icons, String hintText, TextEditingController controller) {
  return Container(
    height: 60.h,
    decoration: BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(100.r)),
    child: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icons,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget customTextForm(String hintText, TextEditingController controller) {
  return Container(
    height: 60.h,
    decoration: BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(100.r)),
    child: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}