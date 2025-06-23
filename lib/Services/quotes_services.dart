import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  Future<Map<String, String>> fetchQuote() async {
    final response = await http.get(
      Uri.parse('https://zenquotes.io/api/quotes/random'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return {'quote': data[0]['q'], 'author': data[0]['a']};
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
