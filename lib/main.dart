import 'dart:io';

import 'package:window_size/window_size.dart';

import 'package:flutter/material.dart';

import 'home.dart';
import 'routes.dart';
import 'first_app/first_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Method');
    setWindowMinSize(const Size(1280.0, 720.0));
  }

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
        homeRoute: (context) => const HomePage(title: 'Главный экран'),
        firstAppRoute: (context) => const FirstApp(title: 'Исходные данные'),
      },
    );
  }
}
