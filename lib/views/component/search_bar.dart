import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchBar() {
  return Container(
    height: 65.h,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(100.r),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            const Icon(
              Icons.search,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Cari jasa yang anda butuhkan',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
