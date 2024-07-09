import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/views/home/home_page_as_admin.dart';
import 'package:refac/views/home/home_page_as_user.dart';
import 'package:refac/views/home/profile/profile_page.dart';

class HomeProvider extends ChangeNotifier {


}

final currentIndexProvider = StateProvider<int>((ref) => 0);

final homeProvider = Provider((ref) => HomeProvider());
