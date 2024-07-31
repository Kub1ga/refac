import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/category/category_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';
import 'package:refac/views/component/custom_text_form.dart';

import '../../../state/auth/auth_provider.dart';

class AddServicesCategory extends ConsumerWidget {
  String name;
  String idCat;
  AddServicesCategory({
    super.key,
    required this.name,
    required this.idCat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProv = ref.watch(categoryProvider);
    final authProv = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add services for $name',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            customTextForm(
              'Services Name',
              categoryProv.servNameController,
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 60.h,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(100.r)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: categoryProv.priceController,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            GestureDetector(
              onTap: () async {
                authProv.loadingState(true);
                try {
                  await categoryProv.addCategoryService(
                      idCat,
                      categoryProv.servNameController.text,
                      categoryProv.priceController.text);
                  Navigator.pop(context);
                  authProv.loadingState(false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      ref.watch(authProvider).snackBarMessage(e.toString()));
                  authProv.loadingState(false);
                }
              },
              child: customButton(
                  RefacTheme().mainColor,
                  authProv.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Tambah Layanan untuk $name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
