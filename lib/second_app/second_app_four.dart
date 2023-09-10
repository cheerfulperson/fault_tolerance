import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

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
    lFactorPoints = provider.lFactorPoints;
    trainingSetVolume = provider.trainingSetVolume;
    validationSetVolume = provider.validationSetVolume;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SecondAppProvider>();
    List<double> averageTime = provider.getTimeAverage();
    List<Forecast> forecastData = provider.getForecast();
    double average = provider.getDepsAverage(forecastData);

    int index = 0;
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
            const SizedBox(
              height: 16,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выбранное значение наработки t:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      ToggleButtons(
                        isSelected: List.generate(averageTime.length,
                            (index) => index == provider.selectedTime),
                        borderWidth: 2,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: (int index) {
                          setState(() {
                            provider.setSelectedTime(index);
                          });
                        },
                        children: averageTime.map((e) {
                          index++;
                          return Text(
                            ' t${index} = ${e.toStringAsFixed(3)} ',
                            style: TextStyle(fontSize: 20),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Функция пересчета:', // Replace with the desired text
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: 720,
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, height: 1),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 2),
                            hintText: '0.3 * x^6',
                            hintStyle: TextStyle(fontSize: 20),
                            labelStyle: TextStyle(fontSize: 2),
                          ),
                          initialValue: provider.fourthFormula,
                          onChanged: (value) {
                            setState(() {
                              provider
                                  .setFourthFormula(value.replaceAll(',', '.'));
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 8),
                  SelectableText.rich(TextSpan(
                      text:
                          '** Если в таблице появилось значение null, то какая-то формула введена неверно.')),
                  const SizedBox(
                    height: 4,
                  ),
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
                      for (int i = 0; i < forecastData.length; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  '${i + 1}',
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
                                  forecastData[i].Ppr?.toStringAsFixed(4) ??
                                      'null',
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  forecastData[i].Pis?.toStringAsFixed(4) ??
                                      'null',
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(text: '△'),
                        TextSpan(text: 'ср', style: TextStyle(fontSize: 14)),
                        TextSpan(text: ' t = ${average}'),
                      ]),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
