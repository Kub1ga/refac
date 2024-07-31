import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:refac/services/admin/api_services_admin.dart';

import '../../../models/list_article.dart';

class ArticleProvider extends ChangeNotifier {
  ApiServicesAdmin apiServicesAdmin = ApiServicesAdmin();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  XFile? image;

  Future<XFile?> chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> pickImage() async {
    final img = await chooseImage();
    image = img;
    notifyListeners();
  }

  Future<void> uploadArticle(
      String title, String content, XFile? imageFile) async {
    var uri = Uri.parse('https://rest-refac.vercel.app/api/v1/article');
    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = title;
    request.fields['content'] = content;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('picture', imageFile.path));
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Article uploaded successfully');
      } else {
        // Read response body for more information
        var responseBody = await response.stream.bytesToString();
        print('Failed to upload article: ${response.statusCode}');
        print('Response: $responseBody');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<ListArticleModel> getAllArticle() async {
    final response = await http.get(
        Uri.parse(apiServicesAdmin.baseUrl + apiServicesAdmin.postArticle),
        headers: {
          'Content-type': 'application/json',
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return ListArticleModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> deleteArticle(int idArticle) async {
    final response = await http.delete(
        Uri.parse(apiServicesAdmin.baseUrl +
            apiServicesAdmin.deleteArticle(idArticle)),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}

final articleProvider =
    ChangeNotifierProvider.autoDispose((ref) => ArticleProvider());

final getAllArticle = FutureProvider.autoDispose((ref) {
  return ref.watch(articleProvider).getAllArticle();
});
