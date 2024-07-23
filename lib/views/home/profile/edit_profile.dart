import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/state/profile/profile_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/component/constant/loading_dialog.dart';
import 'package:refac/views/component/custom_button.dart';

class EditProfilePage extends ConsumerWidget {
  String namaUser;
  String email;
  String dateCreated;
  String phone;
  String address;
  EditProfilePage(
      {super.key,
      required this.namaUser,
      required this.email,
      required this.dateCreated,
      required this.phone,
      required this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameEdit = TextEditingController(text: namaUser);
    TextEditingController phoneEdit = TextEditingController(text: phone);
    TextEditingController addressEdit = TextEditingController(text: address);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: nameEdit,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: email,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Tanggal Bergabung',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: dateCreated,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Nomor Handphone',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: phoneEdit,
                        decoration: const InputDecoration(
                          // hintText: phone,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Alamat',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: addressEdit,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          // hintText: address,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () async {
                ref.watch(authProvider).loadingState(true);
                try {
                  await ref.watch(profileProvider).updateProfile(nameEdit.text,
                      nameEdit.text, phoneEdit.text, addressEdit.text);
                  ref.refresh(getProfileUserAsync.future);
                  ref.watch(authProvider).loadingState(false);
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  ref.watch(authProvider).loadingState(false);
                  ref.watch(authProvider).snackBarMessage(e.toString());
                }
              },
              child: customButton(
                  RefacTheme().mainColor,
                  ref.watch(authProvider).isLoading!
                      ? const CircularProgressIndicator()
                      : Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
