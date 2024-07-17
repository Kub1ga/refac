import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/admin/admin_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';

class TukangServisDetail extends ConsumerWidget {
  int id;
  TukangServisDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTukangServisDetail = ref.watch(getTukangServiceDetailAsync(id));
    final adminProv = ref.watch(adminProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail tukang servis'),
        ),
        body: getTukangServisDetail.when(
          data: (data) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_pin,
                  size: 100,
                ),
                Text(
                  data.data!.name!,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.data!.phone!,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Text(data.data!.skill!),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: GestureDetector(
                    onTap: () {
                      return adminProv.launchWhatsApp(data.data!.phone!);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: RefacTheme().mainColor,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Panggil',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.h,)
              ],
            ));
          },
          error: (error, stackTrace) {
            return Text('error : $error');
          },
          loading: () {
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }
}
