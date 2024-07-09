import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';
import 'package:refac/views/component/custom_text_form.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider);
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
                        child: const Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
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
                child: customTextForm('Email', authProv.emailController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm('Nama Lengkap', authProv.nameController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm(
                    'Nama Pengguna', authProv.usernameController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child:
                    customTextForm('Kata Sandi', authProv.passwordController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: customTextForm(
                    'Ulangi Kata Sandi', authProv.passwordController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: GestureDetector(
                    onTap: () async {
                      final success = await authProv.registerUser(
                          authProv.usernameController.text,
                          authProv.usernameController.text,
                          authProv.emailController.text,
                          authProv.passwordController.text);

                      if (success) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(authProv.snackBarSuccessRegister);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(authProv.snackBarFailedRegister);
                      }
                    },
                    child: customButton(
                      Colors.red,
                      Text(
                        "Buat Akun",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )),
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
