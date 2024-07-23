import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/admin/admin_provider.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/home/admin/add_layanan_per_category.dart';

import '../../component/constant/app_theme.dart';
import '../../component/custom_button.dart';
import '../../component/custom_text_form.dart';

class AddCategoryPage extends ConsumerWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminProv = ref.watch(adminProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            customTextForm('Judul Kategori', adminProv.categoryTitleController),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddLayananPerCategory(
                      categoryTitle: adminProv.categoryTitleController.text,
                    );
                  },
                ));
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan layanan',
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () async {
                adminProv.postCategory(adminProv.categoryTitleController.text);
              },
              child: customButton(
                  RefacTheme().mainColor,
                  Text(
                    'Tambah Layanan',
                    style: TextStyle(
                      fontSize: 14.sp,
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
