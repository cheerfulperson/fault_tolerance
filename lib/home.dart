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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedCard(
                  description:
                      "ПРОГНОЗИРОВАНИЯ НАДЁЖНОСТИ ПОЛУПРОВОДНИКОВЫХ ПРИБОРОВ ПО ЗНАЧЕНИЯМ ИХ ИНФОРМАТИВНЫХ ПАРАМЕТРОВ В НАЧАЛЬНЫЙ МОМЕНТ ВРЕМЕНИ",
                  imagePath: "assets/images/03-24.jpg",
                  isFirst: true,
                  buttonColor: Color.fromARGB(255, 0, 0, 0),
                  toPath: firstAppRoute),
              const SizedBox(
                width: 12,
              ),
              ElevatedCard(
                description:
                    "МЕТОДИКА ИНДИВИДУАЛЬНОГО ПРОГНОЗИРОВАНИЯ ПОСТЕПЕННЫХ ОТКАЗОВ ИЗДЕЛИЙ ЭЛЕКТРОННОЙ ТЕХНИКИ МЕТОДОМ ИМИТАЦИОННЫХ ВОЗДЕЙСТВИЙ",
                imagePath: "assets/images/forecast.jpg",
                toPath: secondAppRoute,
                buttonColor: Color.fromARGB(255, 0, 0, 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedCard extends StatefulWidget {
  static const Color defaultColor = Color(0xEBEBEB);

  ElevatedCard({
    super.key,
    required this.description,
    required this.imagePath,
    required this.toPath,
    this.isFirst = false,
    this.buttonColor = defaultColor,
  });

  final String description;
  final String imagePath;
  final String toPath;
  bool isFirst;
  Color buttonColor;

  @override
  State<ElevatedCard> createState() => _ElevatedCardState();
}

class _ElevatedCardState extends State<ElevatedCard> {
  void handlePress() {
    Navigator.pushNamed(context, widget.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 540,
            height: 540,
            child: Center(
                child: Column(
              children: [
                Image(
                  image: AssetImage(widget.imagePath),
                  width: 520,
                  height: 320,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                Container(
                  height: 110,
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: widget.buttonColor,
                        minimumSize: const Size.fromHeight(50.0)),
                    onPressed: handlePress,
                    child: const Text('Перейти в программу')),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            if (widget.isFirst) {
                              Navigator.pushNamed(context, firstAppInfoPage);
                            } else {
                              Navigator.pushNamed(context, secondAppInfoRoute);
                            }
                          },
                          child: const Text('Как пользоваться пргограммой?')),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            if (widget.isFirst) {
                              Navigator.pushNamed(context, firstAppTheoryPage);
                            } else {
                              Navigator.pushNamed(context, secondAppTheoryPage);
                            }
                          },
                          child: const Text('Теоретические сведения')),
                    )
                  ],
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
