import 'dart:io';
import 'package:Method/second_app/second_app.dart';
import 'package:Method/second_app/second_app_five.dart';
import 'package:Method/second_app/second_app_four.dart';
import 'package:Method/second_app/second_app_three.dart';
import 'package:Method/second_app/second_app_two.dart';
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
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        scaffoldBackgroundColor: Colors.grey.shade200,
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const HomePage(title: 'Главный экран'),
      routes: {
        homeRoute: (context) => const HomePage(title: 'Главный экран'),
        firstAppRoute: (context) => const FirstApp(title: 'Исходные данные'),
        firstAppSecondRoute: (context) => const DataInputTable(
            title: 'Фрагмент результатов ОЭ представлен в таблице'),
        secondAppRoute: (context) =>
            const SecondAppDataFieldsOnePage(title: ''),
        secondAppDatafields: (context) =>
            const SecondAppDataFieldsTwoPage(title: 'Вторая страница'),
        secondAppDatafieldsThreePage: (context) =>
            const SecondAppDataFieldsThreePage(title: 'Третья страница'),
        secondAppDatafieldsFourPage: (context) =>
            const SecondAppDataFieldsFourPage(title: 'Четвертая страница'),
        secondAppDatafieldsFivePage: (context) =>
            const SecondAppDataFieldsFivePage(title: 'Пятая страница'),
      },
    );
  }
}
