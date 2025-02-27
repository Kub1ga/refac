import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/category/category_provider.dart';
import 'package:refac/state/profile/profile_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/order/order_page.dart';

class CategoryServicePage extends ConsumerWidget {
  int idCategory;
  String title;
  CategoryServicePage(
      {super.key, required this.idCategory, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getIdUser = ref.watch(getProfileUserAsync);
    final getDetailCategory = ref.watch(getCategoryDetailAsync(idCategory));
    log('id categorinya $idCategory');
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
                        title,
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
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return OrderPage(
                                  idCategoryService: data.data[index].id!,
                                  idUser: getIdUser.when(
                                    data: (data) {
                                      return data.id!;
                                    },
                                    error: (error, stackTrace) {
                                      return 0;
                                    },
                                    loading: () {
                                      return 0;
                                    },
                                  ),
                                  phone: getIdUser.when(
                                    data: (data) {
                                      return data.phone!;
                                    },
                                    error: (error, stackTrace) {
                                      return '';
                                    },
                                    loading: () {
                                      return '';
                                    },
                                  ),
                                );
                              },
                            ));
                          },
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
                                  data.data[index].nameService!,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
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
