import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/auth/register_page.dart';
import 'package:refac/views/component/custom_button.dart';
import 'package:refac/views/component/custom_text_form.dart';
import 'package:refac/views/home/admin/navbar_home_admin.dart';
import 'package:refac/views/home/home_page_as_admin.dart';
import 'package:refac/views/home/navbar_home.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          color: const Color.fromARGB(255, 0, 14, 95),
          child: Stack(
            children: [
              Container(
                height: 1.sh / 1.60,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Center(
                      child: Image.asset(
                    'assets/icons/logo.png',
                    width: 200.w,
                    height: 200.h,
                  )),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 285),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        height: 350.h,
                        width: 300.w,
                        color: Colors.amber,
                        child: Column(
                          children: [
                            customIconForm(Icon(Icons.account_circle), 'Email',
                                authProv.emailController),
                            SizedBox(
                              height: 16.h,
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
                                    obscureText: authProv.isVisible,
                                    controller: authProv.passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Kata sandi',
                                      prefixIcon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            if (authProv.isVisible == false) {
                                              authProv.changeVisibilityPassword(
                                                  true);
                                            } else {
                                              authProv.changeVisibilityPassword(
                                                  false);
                                            }
                                          },
                                          child: authProv.isVisible
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: authProv.isRememberMeActive,
                                  onChanged: (value) {
                                    authProv.rememberMeChange(value);
                                  },
                                ),
                                Text(
                                  'Ingat saya',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.blue),
                                ),
                                const Spacer(),
                                Text(
                                  'Lupa kata sandi?',
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.blue),
                                ),
                                SizedBox(
                                  width: 18.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                authProv.loadingState(true);
                                if (authProv.emailController.text == 'admin' ||
                                    authProv.passwordController.text ==
                                        'password') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return NavbarHomeAdmin();
                                    },
                                  ));
                                  authProv.loadingState(false);
                                } else {
                                  try {
                                    await authProv.loginAsUser(
                                        authProv.emailController.text,
                                        authProv.passwordController.text);
                                    if (authProv.isRememberMeActive == true) {
                                      authProv.saveToken('token');
                                      print(
                                          'aktif ga ni = ${authProv.isRememberMeActive}');
                                    }
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return NavbarHome();
                                      },
                                    ));

                                    print('as User');
                                    authProv.loadingState(false);
                                    authProv.saveToken(authProv.token!);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        authProv.snackBarMessage('$e'));
                                    authProv.loadingState(false);
                                  }
                                  // final success = await authProv.loginAsUser(
                                  //     authProv.emailController.text,
                                  //     authProv.passwordController.text);
                                  // if (success == true) {
                                  //   print('as User');
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return NavbarHome();
                                  //     },
                                  //   ));
                                  //   authProv.loadingState(false);
                                  // } else {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(authProv.snackBarMessage);
                                  //   authProv.loadingState(false);
                                  // }
                                }
                              },
                              child: customButton(
                                  Colors.red,
                                  authProv.isLoading == true
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Belum memiliki akun?',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const RegisterPage();
                                        },
                                      ),
                                    );
                                    print('object');
                                  },
                                  child: Text(
                                    'Buat akun',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
