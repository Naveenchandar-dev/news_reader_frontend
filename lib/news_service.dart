import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Import to use kIsWeb

class NewsService {
  // Base URL will be determined based on the platform
  final String baseUrl;

  NewsService()
      : baseUrl = kIsWeb
      ? 'http://localhost:5002/api/news' // For web
      : 'http://192.168.1.106:5002/api/news'; // For mobile

  Future<List<dynamic>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load news');
    }
  }
}
