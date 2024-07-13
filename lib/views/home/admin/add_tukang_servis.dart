import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/admin/admin_provider.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';
import 'package:refac/views/component/custom_text_form.dart';

class AddTukangServisPage extends ConsumerWidget {
  const AddTukangServisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminProv = ref.watch(adminProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Tambah tukang servis',
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
            customTextForm('Nama', adminProv.namaTukangServisController),
            SizedBox(
              height: 15.h,
            ),
            customTextForm(
                'Nomor Telepon', adminProv.phoneTukangServisController),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () async {
                adminProv.loadingState(true);
                try {
                  await adminProv.postTukangServis(
                      adminProv.namaTukangServisController.text,
                      adminProv.phoneTukangServisController.text);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Scaffold(
                        body: Center(
                            child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Berhasil Tambah Data',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                  'Nama : ${adminProv.namaTukangServisController.text}'),
                              Text(
                                  'Phone : ${adminProv.phoneTukangServisController.text}'),
                              SizedBox(
                                height: 100.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                  adminProv.namaTukangServisController.clear();
                                  adminProv.phoneTukangServisController.clear();

                                  ref.refresh(getAllTukangServiceAsync);
                                },
                                child: customButton(
                                  RefacTheme().mainColor,
                                  Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                      );
                    },
                  );
                  adminProv.loadingState(false);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(adminProv.snackBarMessage('$e'));
                  adminProv.loadingState(false);
                }
              },
              child: customButton(
                  RefacTheme().mainColor,
                  adminProv.isLoading == true
                      ? const CircularProgressIndicator()
                      : Text(
                          'Tambah tukang servis',
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
