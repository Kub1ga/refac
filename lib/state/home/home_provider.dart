import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/services/user/api_services_user.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:refac/views/home/home_page_as_admin.dart';
import 'package:refac/views/home/home_page_as_user.dart';
import 'package:refac/views/home/profile/profile_page.dart';
import 'package:http/http.dart' as http;

import '../../models/category.dart';

class HomeProvider extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  ApiServicesUser apiServicesUser = ApiServicesUser();


  Future<CategoryModel> getAllCategory() async {
    String? token = await authProvider.getToken('token');
    final response = await http.get(
        Uri.parse(apiServicesUser.baseUrl + apiServicesUser.getKategori),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

final currentIndexProvider = StateProvider<int>((ref) => 0);

final homeProvider = Provider.autoDispose((ref) => HomeProvider());

final getCategoryAsync = FutureProvider.autoDispose((ref) {
  return ref.watch(homeProvider).getAllCategory();
});
