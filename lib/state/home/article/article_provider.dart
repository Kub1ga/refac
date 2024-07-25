import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleProvider extends ChangeNotifier {
  List<ListArticle> article = [
    ListArticle(
        title: 'Materi Aplikasi Prinsip Dasar Refrigerasi',
        image: 'assets/icons/kulkas_dummy.png',
        content:
            """Proses refrigerasi melibatkan siklus kompresi uap, dimana refrigeran (fluida pendingin) dimampatkan menggunakan kompresor, didinginkan pada kondensor, dan kemudian mengembun pada evaporator. Proses ini berulang-ulang untuk mencapai suhu yang lebih dingin.Tekanan dan suhu refrigeran sangat penting dalam proses refrigerasi. Tekanan refrigeran diatur untuk memungkinkan perubahan fase dari cair menjadi gas dan sebaliknya. Suhu refrigeran juga dipengaruhi oleh tekanan dan digunakan untuk mengatur suhu ruangan.""",
        id: 0),
    ListArticle(
        title: 'Materi Aplikasi Prinsip Dasar Air Conditioning (AC)',
        image: 'assets/icons/ac_dummy.png',
        content:
            """Air Conditioning (AC) adalah proses pengkondisian udara yang melibatkan pengkondisian suhu, kelembaban, dan volume udara. Tujuan utama AC adalah untuk menciptakan kondisi udara yang nyaman di dalam ruangan. Komponen kontrol AC meliputi temperatur, kelembaban, dan volume udara. Tekanan dan suhu udara sangat penting dalam AC. Tekanan udara diatur untuk memungkinkan perubahan fase dari cair menjadi gas dan sebaliknya. Suhu udara juga dipengaruhi oleh tekanan dan digunakan untuk mengatur temperatur ruangan.""",
        id: 1)
  ];
}

final articleProvider = ChangeNotifierProvider.autoDispose((ref) => ArticleProvider());

class ListArticle {
  ListArticle({
    required this.title,
    required this.image,
    required this.content,
    required this.id,
  });

  final String? title;
  final String? image;
  final String? content;
  final int? id;
}
