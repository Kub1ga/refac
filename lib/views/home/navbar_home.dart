import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refac/state/home/home_provider.dart';
import 'package:refac/views/component/constant/app_theme.dart';

import 'article/article_page.dart';
import 'home_page_as_user.dart';
import 'profile/profile_page.dart';

class NavbarHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> _children = [
      const HomePageAsUser(),
      const ArticlePage(),
      const ProfilePage()
    ];

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          body: _children[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedLabelStyle:
                TextStyle(color: Colors.white, fontSize: 16.sp),
            // selectedItemColor: Colors.white,
            backgroundColor: RefacTheme().mainColor,
            fixedColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(currentIndexProvider.notifier).update((state) => index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home_navbar.png',
                  height: 40.h,
                  width: 40.w,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/article_navbar.png',
                  height: 40.h,
                  width: 40.w,
                ),
                label: 'Artikel',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile_navbar.png',
                  height: 40.h,
                  width: 40.w,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
