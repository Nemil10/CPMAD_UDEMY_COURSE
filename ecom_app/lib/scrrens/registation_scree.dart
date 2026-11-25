import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create account')),
    body: const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(decoration: InputDecoration(labelText: 'Full name')),
          TextField(decoration: InputDecoration(labelText: 'Email')),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 20),
          _RegisterButton(),
        ],
      ),
    ),
  );
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: () => Navigator.pop(context),
    child: const Text('Register'),
  );
}
