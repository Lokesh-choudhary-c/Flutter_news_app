import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/article_model.dart';


class NewsService {
  final _key = '3c91869f6602d27506fee8fb65ac9364';
  
  Future<List<Article>> fetchTopHeadlines() async {
    final url = Uri.parse('https://gnews.io/api/v4/top-headlines?lang=en&max=20&token=$_key');
    final resp = await http.get(url);
    final data = jsonDecode(resp.body);
    return (data['articles'] as List).map((e) => Article.fromJson(e)).toList();
  }

  Future<List<Article>> searchNews(String q) async {
    final url = Uri.parse('https://gnews.io/api/v4/search?q=$q&lang=en&token=$_key');
    final resp = await http.get(url);
    final data = jsonDecode(resp.body);
    return (data['articles'] as List).map((e) => Article.fromJson(e)).toList();
  }
}

