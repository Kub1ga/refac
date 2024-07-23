import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refac/models/all_order_models.dart';
import 'package:refac/models/tukang_servis_detail.dart';
import 'package:refac/services/admin/api_services_admin.dart';
import 'package:http/http.dart' as http;
import 'package:refac/state/auth/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/add_tukang_servis.dart';
import '../../models/list_tukang_servis.dart';

class AdminProvider extends ChangeNotifier {
  ApiServicesAdmin apiServicesAdmin = ApiServicesAdmin();
  TextEditingController namaTukangServisController = TextEditingController();
  TextEditingController phoneTukangServisController = TextEditingController();
  TextEditingController skillTukangServisController = TextEditingController();

  TextEditingController categoryTitleController = TextEditingController();

  List<MapEntry<String, dynamic>> layanan = [];

  AuthProvider authProv = AuthProvider();
  SnackBar snackBarMessage(String message) {
    return SnackBar(content: Text(message));
  }

  bool? isLoading;
  void loadingState(bool? value) {
    isLoading = value!;
    notifyListeners();
  }

  Future<AddTukangServisModel> postTukangServis(
      String name, String phone, String skill) async {
    String? token = await authProv.getToken('token');
    final response = await http.post(
        Uri.parse(
            apiServicesAdmin.baseUrl + apiServicesAdmin.tambahTukangServis),
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'skill': skill,
        }),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return AddTukangServisModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<ListTukangServis> getAllTukangServis() async {
    final response = await http.get(
      Uri.parse(apiServicesAdmin.baseUrl + apiServicesAdmin.getTukangServis),
      headers: {'Content-type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return ListTukangServis.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<TukangServisDetail> getTukangServisDetail(int idTukangServis) async {
    final response = await http.get(
        Uri.parse(
          apiServicesAdmin.baseUrl +
              apiServicesAdmin.getTukangServicesDetail(idTukangServis),
        ),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TukangServisDetail.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<bool> postCategory(String nameCategory) async {
    String? token = await authProv.getToken('token');
    final response = await http.post(
        Uri.parse(apiServicesAdmin.baseUrl + apiServicesAdmin.createCategory),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode({'category_name': nameCategory}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  void launchWhatsApp(String phone) async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/+62$phone');
    print('Launching WhatsApp URL: $whatsappUrl');

    bool canLaunchWhatsApp = await canLaunchUrl(whatsappUrl);
    print('Can launch WhatsApp: $canLaunchWhatsApp');

    if (canLaunchWhatsApp) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch WhatsApp URL: $whatsappUrl');
      await launch(whatsappUrl.toString());
    }
  }

  Future<AllOrderModels> getAllOrder() async {
    final response = await http.get(
      Uri.parse(apiServicesAdmin.baseUrl + apiServicesAdmin.getAllOrder),
      headers: {'Content-type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllOrderModels.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['messages']);
    }
  }
}

final adminProvider = Provider((ref) => AdminProvider());

final getAllTukangServiceAsync = FutureProvider.autoDispose((ref) {
  return ref.watch(adminProvider).getAllTukangServis();
});

final getTukangServiceDetailAsync =
    FutureProvider.autoDispose.family<TukangServisDetail, int>((ref, id) {
  return ref.watch(adminProvider).getTukangServisDetail(id);
});

final getAllOrderAsync = FutureProvider.autoDispose((ref) {
  return ref.watch(adminProvider).getAllOrder();
});
