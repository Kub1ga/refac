import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/main.dart';
import 'package:refac/views/component/constant/app_theme.dart';
import 'package:refac/views/home/admin/add_article.dart';
import 'package:refac/views/home/admin/add_tukang_servis.dart';
import 'package:refac/views/home/home_page_as_admin.dart';

import '../../../state/home/home_provider.dart';
import 'add_category_page.dart';

class NavbarHomeAdmin extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> _children = [
      HomePageAsAdmin(),
      AddTukangServisPage(),
      AddCategoryPage(),
      AddArticle(),
    ];

    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: RefacTheme().mainColor,
        unselectedItemColor: RefacTheme().mainColor,
        selectedItemColor: RefacTheme().mainColor,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).update((state) => index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Tambah Teknisi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'Layanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_sharp),
            label: 'Tambah Artikel',
          ),
        ],
      ),
    );
  }
}
