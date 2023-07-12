import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'components/header.dart';
import '../routes.dart';
import 'components/nav_bar.dart';
import '../providers/second_app_providers.dart';

void _navigateToNextPage(BuildContext context) {

  Navigator.pushNamed(
    context,
    secondAppDatafieldsFivePage,
  );
}

class SecondAppDataFieldsFourPage extends StatefulWidget {
  final String title;

  const SecondAppDataFieldsFourPage({Key? key, required this.title})
      : super(key: key);

  @override
  _SecondAppDataFieldsFourPageState createState() =>
      _SecondAppDataFieldsFourPageState();
}

class _SecondAppDataFieldsFourPageState
    extends State<SecondAppDataFieldsFourPage> {

  late List<List<int>> tableData;
  int n = 0;
  int runningTime = 0;
  int lFactorPoints = 5;
  int trainingSetVolume = 1;
  int validationSetVolume = 0;
  int testValue = 0;

// Нужно написать по расчету формулы (6) методы

  @override
  void initState() {
    super.initState();
    // Размеры таблицы

    final provider = Provider.of<SecondAppProvider>(context, listen: false);
    lFactorPoints = int.parse(provider.lFactorPoints);
    trainingSetVolume = int.parse(provider.trainingSetVolume);
    validationSetVolume = int.parse(provider.validationSetVolume);

    // Создание таблицы с заданными размерами
    tableData = List.generate(
      trainingSetVolume + validationSetVolume + 1,
      (_) => List<int>.filled(lFactorPoints + 1, 0),
    );

    // Заполнение текстом столбца k
    for (int i = 0; i <= lFactorPoints; i++) {
      tableData[0][i] = i == 0 ? 0 : i;
    }

    // Заполнение текстом строки s
    for (int j = 0; j <= trainingSetVolume + validationSetVolume; j++) {
      tableData[j][0] = j == 0 ? 0 : j;
    }

    // Заполнение значений второго столбца "Pпр i"
    for (int i = 1; i <= trainingSetVolume + validationSetVolume; i++) {
      tableData[i][1] = i;
    }

    // Заполнение текстом третьего столбца "Pист i"
    for (int i = 1; i <= trainingSetVolume + validationSetVolume; i++) {
      tableData[i][2] = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                SecondAppNavBar(),
              ],
            ),
            SizedBox(
              width: 1020,
              height: MediaQuery.of(context).size.height - 160,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8.0,
                ),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Таблица 5 - Зависимость параметра P i-го экземпляра объединенной выборки от наработки t',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                'Значение t, час',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                'Pпр i',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                'Pист i',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 1; i <= 0 + validationSetVolume; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  '$i',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  'Pпр $i',
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  'Pист $i',
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '№ экземпляра множества m, для которого отобразить среднюю ошибку прогнозирования:', // Replace with the desired text
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: 720,
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, height: 1),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 2),
                            hintText: '10',
                            hintStyle: TextStyle(fontSize: 20),
                            labelStyle: TextStyle(fontSize: 2),
                          ),
                          onChanged: (value) {
                            setState(() {
                              testValue = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        // Здесь должен отображаться результат работы функции по расчту формулы (6),
                        // testValue выводится для примера
                        'Результат: $testValue',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    title: 'Second App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: SecondAppDataFieldsFourPage(title: 'Second App'),
    routes: {
      '/secondAppDatafieldsNext': (context) =>
          SecondAppDataFieldsNextPage(title: 'Next App'),
    },
  ));
}

class SecondAppDataFieldsNextPage extends StatelessWidget {
  final String title;

  const SecondAppDataFieldsNextPage({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the next page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
