import 'package:flutter/material.dart';

import 'components/app_header.dart';
import 'routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Главный экран',
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedCardExample(
                  description:
                      "ПРОГНОЗИРОВАНИЯ НАДЁЖНОСТИ ПОЛУПРОВОДНИКОВЫХ ПРИБОРОВ ПО ЗНАЧЕНИЯМ ИХ ИНФОРМАТИВНЫХ ПАРАМЕТРОВ В НАЧАЛЬНЫЙ МОМЕНТ ВРЕМЕНИ",
                  imagePath: "assets/images/first-app.png",
                  toPath: firstAppRoute),
              const SizedBox(
                width: 20,
              ),
              ElevatedCardExample(
                description:
                    "МЕТОДИКА ИНДИВИДУАЛЬНОГО ПРОГНОЗИРОВАНИЯ НАДЁЖНОСТИ БИПОЛЯРНЫХ ТРАНЗИСТОРОВ ПО ПОСТЕПЕННЫМ ОТКАЗАМ",
                imagePath: "assets/images/second-app.png",
                toPath: secondAppRoute,
                buttonColor: Colors.deepPurple.shade300,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedCardExample extends StatefulWidget {
  static const Color defaultColor = Color(0xFF42A5F5);

  ElevatedCardExample({
    super.key,
    required this.description,
    required this.imagePath,
    required this.toPath,
    this.buttonColor = defaultColor,
  });

  final String description;
  final String imagePath;
  final String toPath;
  Color buttonColor;

  @override
  State<ElevatedCardExample> createState() => _ElevatedCardExampleState();
}

class _ElevatedCardExampleState extends State<ElevatedCardExample> {
  void handlePress() {
    Navigator.pushNamed(context, widget.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 400,
            height: 320,
            child: Center(
                child: Column(
              children: [
                Image(
                  image: AssetImage(widget.imagePath),
                  width: 180,
                  height: 160,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: widget.buttonColor,
                        minimumSize: const Size.fromHeight(50.0)),
                    onPressed: handlePress,
                    child: const Text('Перейти в программу'))
              ],
            )),
          ),
        ),
      ),
    );
  }
}
