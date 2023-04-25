import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'routes.dart';
import 'first_app/first_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Главный экран'),
      routes: {
        homeRoute: (context) =>
            const HomePage(title: 'Главный экран'),
        firstAppRoute: (context) =>
            const FirstApp(title: 'Главный экран'),
      },
    );
  }
}
