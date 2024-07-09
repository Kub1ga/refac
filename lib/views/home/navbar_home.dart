import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/state/home/home_provider.dart';

import 'home_page_as_user.dart';
import 'profile/profile_page.dart';

class NavbarHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> _children = [HomePageAsUser(), ProfilePage()];

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
            icon: Icon(Icons.search),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
