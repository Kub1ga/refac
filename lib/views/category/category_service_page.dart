import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/category/category_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';

class CategoryServicePage extends ConsumerWidget {
  int idCategory;
  CategoryServicePage({super.key, required this.idCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProv = ref.watch(categoryProvider);
    final getDetailCategory = ref.watch(getCategoryDetailAsync(idCategory));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 100.h,
          flexibleSpace: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100.h,
                  // width: 1.sw,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset('assets/icons/logo.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: getDetailCategory.when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1.sw,
                  // height: 80.h,
                  color: RefacTheme().mainColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Nama Layanannya',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Layanan yang tersedia',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          width: 300.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Layanan yang tersedianya',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('Error: $error'),
            );
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
