import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/services/user/api_services_user.dart';
import 'package:refac/state/auth/auth_provider.dart';
import 'package:http/http.dart' as http;

import '../../models/create_order.dart';

class OrderProvider extends ChangeNotifier {
  ApiServicesUser apiServicesUser = ApiServicesUser();
  AuthProvider authProvider = AuthProvider();
  TextEditingController deskripsiController = TextEditingController();

  Future<void> createOder(int idService, int idUser) async {
    String? token = await authProvider.getToken('token');
    final response = await http.post(
      Uri.parse(apiServicesUser.baseUrl + apiServicesUser.userOrder),
      headers: {
        'Authorization' : 'Bearer $token',
        'Content-type': 'application/json'
      },
      body: jsonEncode({
        'id_category_service': idService,
        'id_users': idUser,
        'description' : deskripsiController.text
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      print(response.body);
      print(apiServicesUser.baseUrl + apiServicesUser.userOrder);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

final orderProvider = ChangeNotifierProvider((ref) => OrderProvider());
