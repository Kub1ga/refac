import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      AddCategoryPage()
    ];

    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        ],
      ),
    );
  }
}
