import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:refac/models/login_response.dart';
import 'package:refac/services/user/api_services_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? token;

  bool? isLoading;
  void loadingState(bool? value) {
    isLoading = value!;
    notifyListeners();
  }

  bool isRememberMeActive = false;

  ApiServicesUser apiServices = ApiServicesUser();

  // String snackBarMessage = 'Data Users not found. Please use the registred Account!';
  SnackBar snackBarMessage(String message) {
    return SnackBar(content: Text(message));
  }

  SnackBar snackBarSuccessRegister = const SnackBar(
      content: Text('Account Registred Successfully. You can login Now!'));

  SnackBar snackBarFailedRegister =
      const SnackBar(content: Text('Gagal membuat akun!'));

  Future<LoginResponseModel> loginAsUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiServices.baseUrl + apiServices.userLogin),
      headers: {
        'Content-type': 'application/json',
        'JWT_KEY':
            '0280cbd06f39cd0a68209a5529ab2304f3cc240c0a4b70c93bbee5d250d1d8048635b98e18a8d296abd8a3803587926dff3d343b16a0bb99cc7b16f64680c301'
      },
      body: jsonEncode(
        {'email': email, 'password': password},
      ),
    );
    final loginModel = LoginResponseModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      token = loginModel.token;
      print(response.body);
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<bool> registerUser(
      String name, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse(apiServices.baseUrl + apiServices.userRegister),
      headers: {
        'Content-type': 'application/json',
        'JWT_KEY':
            '0280cbd06f39cd0a68209a5529ab2304f3cc240c0a4b70c93bbee5d250d1d8048635b98e18a8d296abd8a3803587926dff3d343b16a0bb99cc7b16f64680c301'
      },
      body: jsonEncode(
        {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  void rememberMeChange(bool? value) {
    isRememberMeActive = value!;
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
