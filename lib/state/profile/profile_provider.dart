import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/models/detail_user.dart';
import 'package:refac/services/user/api_services_user.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  AuthProvider authProvider = AuthProvider();
  ApiServicesUser apiServicesUser = ApiServicesUser();

  Future<DetailUserModel> getDetailUser() async {
    String? token = await authProvider.getToken('token');
    final response = await http.get(
      Uri.parse(apiServicesUser.baseUrl + apiServicesUser.getUserDetail),
      headers: {'Content-type': 'application/json', 'Authorization': '$token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return DetailUserModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

final profileProvider = Provider((ref) => ProfileProvider());

final getProfileUserAsync = FutureProvider.autoDispose((ref) {
  return ref.watch(profileProvider).getDetailUser();
});
