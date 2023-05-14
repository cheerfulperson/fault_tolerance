import 'dart:io';
import 'package:window_size/window_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'routes.dart';
import 'first_app/first_app.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/first_app/data_input_table.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Method');
    setWindowMinSize(const Size(1280.0, 720.0));
  }

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => FirstAppProvider())],
    child: const MyApp(),
  ));
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
        firstAppDataRoute: (context) => const DataInputTable(
            title: 'Фрагмент результатов ОЭ представлен в таблице'),
      },
    );
  }
}
