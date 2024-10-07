import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'news_service.dart';

class NewsProvider with ChangeNotifier {
  List<dynamic> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<dynamic> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  NewsProvider() {
    _loadSavedArticles(); // Load saved articles on initialization
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newsService = NewsService();
      _articles = await newsService.fetchNews();
      await _saveArticlesToLocal(); // Save fetched articles locally
    } catch (e) {
      _errorMessage = 'Failed to load news. Please try again.';
      await _loadSavedArticles(); // Load saved articles if fetching fails
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveArticlesToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_articles', json.encode(_articles));
  }

  Future<void> _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedArticles = prefs.getString('saved_articles');
    if (savedArticles != null) {
      _articles = json.decode(savedArticles);
    } else {
      _articles = []; // Reset to an empty list if no saved articles
    }
    notifyListeners(); // Notify listeners after loading saved articles
  }
}
