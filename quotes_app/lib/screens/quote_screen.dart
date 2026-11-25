import 'package:flutter/material.dart';

import '../models/quote_model.dart';

class QuoteScreen extends StatelessWidget {
  final Quote quote;

  const QuoteScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '“${quote.content}”',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text('— ${quote.author}'),
            ],
          ),
        ),
      ),
    );
  }
}
