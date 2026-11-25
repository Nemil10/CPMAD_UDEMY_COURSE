import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const RandomColorApp());
}

class RandomColorApp extends StatelessWidget {
  const RandomColorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomColorPage(),
    );
  }
}

class RandomColorPage extends StatefulWidget {
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  final Random _random = Random();

  Color _backgroundColor = Colors.red;
  Color _textColor = Colors.white;
  Color _buttonColor = Colors.blue;

  Color _randomColor() {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      1,
    );
  }

  Color _contrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void _changeColors() {
    setState(() {
      _backgroundColor = _randomColor();
      _textColor = _contrastColor(_backgroundColor);
      _buttonColor = _randomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Text(
          'Hello, Flutter!',
          style: TextStyle(
            color: _textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeColors,
        backgroundColor: _buttonColor,
        child: Icon(Icons.color_lens, color: _contrastColor(_buttonColor)),
      ),
    );
  }
}
