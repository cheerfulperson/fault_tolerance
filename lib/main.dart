import 'dart:io';
import 'package:Method/first_app/app_info.dart';
import 'package:Method/first_app/logic_tables_page.dart';
import 'package:Method/first_app/probabilit_assessment_page.dart';
import 'package:Method/first_app/results.dart';
import 'package:window_size/window_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:Method/first_app/first_app.dart';
import 'package:Method/first_app/first_app_centered_values.dart';
import 'package:Method/first_app/fr_results_page.dart';
import 'package:Method/first_app/fr_transform_page.dart';
import 'package:Method/first_app/private_information.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/providers/second_app_providers.dart';
import 'package:Method/second_app/second_app.dart';
import 'package:Method/second_app/second_app_semi.dart';
import 'package:Method/second_app/second_app_five.dart';
import 'package:Method/second_app/second_app_four.dart';
import 'package:Method/second_app/second_app_three.dart';
import 'package:Method/second_app/second_app_two.dart';
import 'home.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Method');
    setWindowMinSize(const Size(1480.0, 720.0));
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FirstAppProvider()),
      ChangeNotifierProvider(create: (_) => SecondAppProvider())
    ],
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

        // First app Routes
        firstAppRoute: (context) => const FirstApp(title: 'Исходные данные'),
        firstAppSecondRoute: (context) => const FRResultsPage(title: ''),
        firstAppCenteredValuesRoute: (context) =>
            const FirstAppCenteredValues(title: ''),
        firstAppTransformationRoute: (context) =>
            const FRTransformPage(title: ''),
        firstAppProbabilityAssessmentPage: (context) =>
            const ProbabilityAssessmentPage(title: ''),
        firstAppLogicTablesPage: (context) => const LogicTablesPage(title: ''),
        firstAppPrivateInformationPage: (context) =>
            const PrivateInformationPage(title: ''),
        firstAppResultsPage: (context) => const FirstAppResults(title: ''),
        firstAppInfoPage: (context) =>
            const FirstAppInfoPage(link: 'assets/files/first_app_int.pdf'),
        firstAppTheoryPage: (context) =>
            const FirstAppInfoPage(link: 'assets/files/first_app_teo.pdf'),
        // Second app Routes
        secondAppRoute: (context) =>
            const SecondAppDataFieldsOnePage(title: ''),
        secondAppDatafieldsSemi: (context) =>
            const SecondAppDataFieldsSemiPage(title: ''),
        secondAppDatafields: (context) =>
            const SecondAppDataFieldsTwoPage(title: 'Вторая страница'),
        secondAppDatafieldsThreePage: (context) =>
            const SecondAppDataFieldsThreePage(title: 'Третья страница'),
        secondAppDatafieldsFourPage: (context) =>
            const SecondAppDataFieldsFourPage(title: 'Четвертая страница'),
        secondAppDatafieldsFivePage: (context) =>
            const SecondAppDataFieldsFivePage(title: 'Пятая страница'),
        secondAppTheoryPage: (context) =>
            const FirstAppInfoPage(link: 'assets/files/second_app_info.pdf'),
        secondAppInfoRoute: (context) =>
            const FirstAppInfoPage(link: 'assets/files/second_app_int.pdf'),
      },
    );
  }
}
