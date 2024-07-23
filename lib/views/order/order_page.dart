import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/state/home/category/category_provider.dart';
import 'package:refac/state/order/order_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/custom_button.dart';

class OrderPage extends ConsumerWidget {
  int idCategory;
  int idUser;
  OrderPage({super.key, required this.idCategory, required this.idUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getServiceDetail = ref.watch(getCategoryDetailAsync(idCategory));
    print('id_category : $idCategory');
    print('id_user : $idUser');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: getServiceDetail.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(197, 2, 218, 66),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(data.data!.nameService!),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Harga',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      width: 3,
                      color: RefacTheme().mainColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rp. ${data.data!.price!.toString()}'),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Deskripsi',
                  style: TextStyle(fontSize: 16.sp),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      width: 3,
                      color: RefacTheme().mainColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: ref.watch(orderProvider).deskripsiController,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    ref.watch(authProvider).loadingState(true);
                    try {
                      await ref
                          .watch(orderProvider)
                          .createOder(idCategory, idUser);
                      ref.watch(authProvider).loadingState(false);
                      ScaffoldMessenger.of(context).showSnackBar(ref
                          .watch(authProvider)
                          .snackBarMessage('Berhasil, harap tunggu teknisi datang'));
                      Navigator.pop(context);
                    } catch (e) {
                      ref.watch(authProvider).loadingState(false);
                      ScaffoldMessenger.of(context).showSnackBar(ref
                          .watch(authProvider)
                          .snackBarMessage(e.toString()));
                    }
                  },
                  child: customButton(
                      RefacTheme().mainColor,
                      ref.watch(authProvider).isLoading!
                          ? const CircularProgressIndicator()
                          : Text(
                              'Order',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            )),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error : $error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
