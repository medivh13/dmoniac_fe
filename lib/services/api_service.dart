// File: lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demoniac_fe/models/article.dart';

class ApiService {
  // static const baseUrl = 'http://192.168.48.33:8000/api';
  static const baseUrl = 'http://localhost:8000/api';

  // final response = await http.get(Uri.parse('http://localhost:8000/api/dmoniacs?user_id=2'))

  Future<List<Article>> getArticlesByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/dmoniacs?user_id=$userId'));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['data'];
      List<Article> articles = [];
      for (var item in jsonData) {
        Article article = Article(
          id: item['id'],
          userId: item['user_id'],
          userName: item['user_name'],
          stadium: item['stadium'],
          createdAt: item['created_at'],
        );
        articles.add(article);
      }
      return articles;
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<> createDataRiwayatByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/dmoniacs'));
  }
}
