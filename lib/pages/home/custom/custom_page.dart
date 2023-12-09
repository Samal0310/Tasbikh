import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomPage')),
      body: TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/');
          context.go('/');
        },
        child: const Text('Вернуться на ГЛАВНУЮ'),
      ),
    );
  }
}
