import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/quote_model.dart';

class QuotesService {
  static Future<Quote> fetchQuote({http.Client? client}) async {
    final httpClient = client ?? http.Client();
    try {
      final response = await httpClient.get(
        Uri.parse('https://zenquotes.io/api/random'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }

      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isEmpty) {
        throw Exception('No quote data found');
      }

      return Quote.fromJson(data.first as Map<String, dynamic>);
    } finally {
      if (client == null) {
        httpClient.close();
      }
    }
  }
}
