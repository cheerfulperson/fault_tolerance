import 'package:flutter/material.dart';

class BigCard extends Card {
  const BigCard({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('A random AWESOME idea:'),
          ElevatedButton(
            onPressed: () {},
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
