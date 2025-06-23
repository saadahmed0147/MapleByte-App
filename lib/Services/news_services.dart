import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String _apiKey = '6bae37903fcf4e7c9acc3ba3fdfcbeaf';
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchTopHeadlines({
    String category = 'general',
    String? query,
  }) async {
    final url = query != null && query.isNotEmpty
        ? '$_baseUrl/everything?q=$query&apiKey=$_apiKey'
        : '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
