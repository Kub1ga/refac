import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/admin/admin_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/home/admin/add_tukang_servis.dart';
import 'package:refac/views/home/admin/tukang_servis_detail_page.dart';

class HomePageAsAdmin extends ConsumerWidget {
  const HomePageAsAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllTukangServis = ref.watch(getAllTukangServiceAsync);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home as Admin',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.logout_rounded,
            color: Colors.red,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              getAllTukangServis.when(
                data: (data) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return TukangServisDetail(
                                      id: data.data[index].id!);
                                },
                              ));
                              print(data.data[index].id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Icon(Icons.people),
                                    SizedBox(
                                      width: 18.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.data[index].name!),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(data.data[index].phone!),
                                        SizedBox(height: 8.h,),
                                        Text(data.data[index].skill!)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: RefacTheme().mainColor,
                            thickness: 10,
                          )
                        ],
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Text('error: $error');
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
