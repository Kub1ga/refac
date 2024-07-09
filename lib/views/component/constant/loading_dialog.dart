import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(32),
          child: const CircularProgressIndicator(),
        ),
      ),
    ),
  );
}