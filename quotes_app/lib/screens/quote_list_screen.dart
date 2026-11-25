import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/quote_model.dart';

class QuoteListScreen extends StatefulWidget {
  const QuoteListScreen({super.key});

  @override
  State<QuoteListScreen> createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  Quote? quote;
  bool loading = false;
  String? error;

  Future<void> fetchQuote() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api.quotable.io/random'),
      );
      if (response.statusCode != 200) {
        throw Exception('Request failed: ${response.statusCode}');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() => quote = Quote.fromJson(data));
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotes')),
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : error != null
            ? Text(error!)
            : quote == null
            ? const Text('No quote available')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('“${quote!.content}”', textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('— ${quote!.author}'),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loading ? null : fetchQuote,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
