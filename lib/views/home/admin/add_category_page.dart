import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/admin/admin_provider.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/home/admin/add_services_as_category.dart';

import '../../../state/home/home_provider.dart';
import '../../component/constant/app_theme.dart';
import '../../component/custom_button.dart';
import '../../component/custom_text_form.dart';

class AddCategoryPage extends ConsumerWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminProv = ref.watch(adminProvider);
    final getCategory = ref.watch(getCategoryAsync);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            getCategory.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          print(data.data[index].id!);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return AddServicesCategory(
                                name: data.data[index].categoryName!,
                                idCat: data.data[index].id.toString(),
                              );
                            },
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: RefacTheme().mainColor)),
                          child: Center(
                            child: Text(data.data[index].categoryName!),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text('error : $error'),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            customTextForm('Judul Kategori', adminProv.categoryTitleController),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () async {
                adminProv.postCategory(adminProv.categoryTitleController.text);

                ref.refresh(getCategoryAsync.future);
              },
              child: customButton(
                  RefacTheme().mainColor,
                  Text(
                    'Tambah Kategori',
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
