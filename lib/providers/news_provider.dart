import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
import 'package:news/services/news_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NewsProvider extends ChangeNotifier {
  final NewsService _service = NewsService();
  List<Article> articles = [];
  List<Article> bookmarks = [];
  bool isLoggedIn = false;
  bool loginStatusLoaded = false;

  NewsProvider() {
    loadLoginStatus();
    loadBookmarks();
  }

  Future<void> fetchNews() async {
    articles = await _service.fetchTopHeadlines();
    notifyListeners();
  }

  Future<void> searchArticles(String query) async {
    articles = await _service.searchNews(query);
    notifyListeners();
  }

  void addBookmark(Article a) async {
    if (!bookmarks.any((x) => x.url == a.url)) {
      bookmarks.add(a);
      await _saveBookmarks();
      notifyListeners();
    }
  }

  void removeBookmark(Article a) async {
    bookmarks.removeWhere((x) => x.url == a.url);
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = bookmarks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('bookmarks', list);
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('bookmarks') ?? [];
    bookmarks = list.map((s) => Article.fromJson(jsonDecode(s))).toList();
    notifyListeners();
  }

  Future<void> setLogin(bool v) async {
    isLoggedIn = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', v);
    notifyListeners();
  }

  Future<void> loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    loginStatusLoaded = true;
    notifyListeners();
  }

bool isBookmarked(Article article) {
  return bookmarks.any((a) => a.url == article.url);
}


  void logout() => setLogin(false);
}

