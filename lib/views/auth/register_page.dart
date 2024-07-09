import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';
import 'package:refac/views/component/custom_text_form.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: RefacTheme().mainColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.list_rounded,
                        size: 40,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'BUAT AKUN\nANDA',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: customTextForm('Email', TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm('Nama Lengkap', TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm('Nama Pengguna', TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm('Kata Sandi', TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm('Ulangi Kata Sandi', TextEditingController()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customButton(Colors.red, 'Buat Akun'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 30),
                child: SizedBox(
                  height: 80.h,
                  width: 80.w,
                  child: Image.asset('assets/icons/logo.png'),
                ),
              )
            ],
          ),
        ));
  }
}
