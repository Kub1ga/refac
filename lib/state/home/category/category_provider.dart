import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/models/category_detail.dart';
import 'package:refac/services/user/api_services_user.dart';
import 'package:http/http.dart' as http;

import '../../../models/list_service.dart';

class CategoryProvider extends ChangeNotifier {
  ApiServicesUser apiServicesUser = ApiServicesUser();
  TextEditingController servNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<CategoryDetailModel> getCategoryDetail(int idCategory) async {
    final response = await http.get(
      Uri.parse(
        apiServicesUser.baseUrl + apiServicesUser.getDetailCategory(idCategory),
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return CategoryDetailModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);

      throw Exception(jsonDecode(response.body));
    }
  }

  Future<CategoryDetailModel> getDetailService(int idService) async {
    final response = await http.get(
      Uri.parse(
        apiServicesUser.baseUrl +
            apiServicesUser.getDetailServiceById(idService),
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CategoryDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<ListServiceModel> getAllService() async {
    final response = await http.get(
      Uri.parse(apiServicesUser.baseUrl + apiServicesUser.getAllService),
      headers: {
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ListServiceModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> addCategoryService(
      String idCat, String nameServ, String price) async {
    final response = await http.post(
        Uri.parse(apiServicesUser.baseUrl + apiServicesUser.createService),
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(
            {'id_category': idCat, 'name_service': nameServ, 'price': price}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      print(response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

final categoryProvider = ChangeNotifierProvider((ref) => CategoryProvider());

final getCategoryDetailAsync =
    FutureProvider.family.autoDispose<CategoryDetailModel, int>((ref, id) {
  return ref.watch(categoryProvider).getCategoryDetail(id);
});

final getAllServiceAsync = FutureProvider.autoDispose((ref) {
  return ref.watch(categoryProvider).getAllService();
});

final getDetailServiceAsync = FutureProvider.autoDispose
    .family<CategoryDetailModel, int>((ref, idService) {
  return ref.watch(categoryProvider).getDetailService(idService);
});
