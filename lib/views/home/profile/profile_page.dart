import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/state/home/home_provider.dart';
import 'package:refac/state/profile/profile_provider.dart';
import 'package:refac/views/auth/login_page.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/home/profile/edit_profile.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider);
    final getProfileUser = ref.watch(getProfileUserAsync);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              Container(
                height: 100.h,
                width: 1.sw / 1.3,
                color: const Color.fromARGB(255, 0, 14, 95),
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications,
                        size: 40,
                        color: Colors.amber,
                      ),
                    )),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            getProfileUser.when(
              data: (data) {
                return Container(
                  height: 150.h,
                  width: 1.sw,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outlined,
                          size: 70.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              data.email!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              print('${await authProv.getToken('token')}');
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return EditProfilePage(
                                    namaUser: data.name!,
                                    email: data.email!,
                                    dateCreated: data.createdAt!.toIso8601String(),
                                    address: data.address,
                                    phone: data.phone,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              height: 60.h,
                              color: RefacTheme().mainColor,
                              child: Center(
                                  child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text('Error : $error');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
            Divider(
              color: RefacTheme().mainColor,
              thickness: 6,
            ),
            getProfileUser.when(
              data: (data) {
                return Container(
                  height: 190.h,
                  width: 1.sw,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor handphone',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          data.phone == null
                              ? '       Belum ada nomor'
                              : '       ${data.phone}',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Alamat',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          data.address == null
                              ? '       Belum ada alamat'
                              : '       ${data.address}',
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text('error : $error');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
            Divider(
              color: RefacTheme().mainColor,
              // height: 80,
              thickness: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lock),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Ubah kata sandi',
                        style: TextStyle(fontSize: 16.sp, color: Colors.amber),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.login_rounded),
                      SizedBox(
                        width: 18.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          authProv.deleteAll();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ));

                          ref
                              .watch(currentIndexProvider.notifier)
                              .update((state) => 0);
                        },
                        child: Text(
                          'Keluar dari akun',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.amber),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
