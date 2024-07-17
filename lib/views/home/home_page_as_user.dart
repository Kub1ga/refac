import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/home_provider.dart';
import 'package:refac/views/component/search_bar.dart';

class HomePageAsUser extends ConsumerWidget {
  const HomePageAsUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCategory = ref.watch(getCategoryAsync);
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
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(width: 1.sw, child: searchBar()),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Text(
                      'Jasa Terpopuler',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                height: 260.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('go to jasa terpopuler');
                            },
                            child: SizedBox(
                              height: 230.h,
                              width: 230.w,
                              child: Image.asset(
                                'assets/icons/dummy.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            'Daily Cleaning',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              getCategory.when(
                data: (data) {
                  return SizedBox(
                    height: 400.h,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.85,
                        crossAxisCount: 3,
                      ),
                      shrinkWrap: true,
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeujOaRWnmiTkG15-RkZrieVZ_JKumVf1CPQ&s',
                                    width: 60.w,
                                    height: 60.h,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    data.data[index].categoryName!
                                        .toUpperCase()
                                        .replaceAll('_', ' '),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text('error : $error');
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
