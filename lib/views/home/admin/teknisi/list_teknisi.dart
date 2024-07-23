import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../state/admin/admin_provider.dart';
import '../../../component/constant/app_theme.dart';
import '../tukang_servis_detail_page.dart';

class ListTeknisi extends ConsumerWidget {
  const ListTeknisi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllTukangServis = ref.watch(getAllTukangServiceAsync);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teknisi tersedia',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                            "Skill : ${data.data[index].skill!.toTitleCase()}")
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
