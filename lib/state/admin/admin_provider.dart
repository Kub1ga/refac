import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      String name, String phone) async {
    String? token = await authProv.getToken('token');
    final response = await http.post(
        Uri.parse(
            apiServicesAdmin.baseUrl + apiServicesAdmin.tambahTukangServis),
        body: jsonEncode({
          'name': name,
          'phone': phone,
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

  void launchWhatsApp(String phone) async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/+62$phone');

    // For debugging
    print('Launching WhatsApp URL: $whatsappUrl');

    bool canLaunchWhatsApp = await canLaunchUrl(whatsappUrl);
    print('Can launch WhatsApp: $canLaunchWhatsApp');

    if (canLaunchWhatsApp) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // For debugging
      print('Could not launch WhatsApp URL: $whatsappUrl');

      // Alternative method
      await launch(whatsappUrl.toString());
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
