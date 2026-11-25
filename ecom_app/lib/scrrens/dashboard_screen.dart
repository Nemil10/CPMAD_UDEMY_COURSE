import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Ecom App')),
    body: const Center(
      child: Text('Welcome to the shop', style: TextStyle(fontSize: 22)),
    ),
  );
}
