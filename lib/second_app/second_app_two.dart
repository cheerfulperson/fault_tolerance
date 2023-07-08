import 'package:flutter/material.dart';
import '../routes.dart';
import 'components/header.dart';

void _navigateToThreePage(BuildContext context) {
  Navigator.pushNamed(
    context,
    secondAppDatafieldsThreePage,
  );
}

class SecondAppDataFieldsTwoPage extends StatefulWidget {
  final String title;

  const SecondAppDataFieldsTwoPage({Key? key, required this.title})
      : super(key: key);

  @override
  _SecondAppDataFieldsTwoPageState createState() =>
      _SecondAppDataFieldsTwoPageState();
}

class _SecondAppDataFieldsTwoPageState
    extends State<SecondAppDataFieldsTwoPage> {
  List<List<int>> tableData = List.generate(2, (_) => List<int>.filled(10, 0));
  List<int> rightColumnData = List.generate(10, (index) => index + 1);
  int n = 0;
  int lFactorPoints = 5;

  // void _navigateToSecondPage(BuildContext context) {
  //   Navigator.pushNamed(
  //     context,
  //     '/secondAppDatafieldsThree',
  //   );
  // }

// Нужно создать функцию расчета формулы (3)
//
//

  @override
  Widget build(BuildContext context) {
    int result = 2 * n;
    String resultText = 'Результат: $result';
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: 1020,
                height: screenHeight - 160,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8.0,
                  ),
                  children: [
                    Text(
                      'Таблица 2 - Зависимость параметра P от тока коллектора Ik',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Table(
                      // Правую ячейку второй строки нужно заполнить ср. арифм. значением ячеек  P1 (Ik1),
                      // P2 (Ik1), P3 (Ik3) и тд. из первой таблицы, правую ячейку третьей строки - ср. арифм.
                      //значением ячеек  P1 (Ik2), P2 (Ik2), P3 (Ik2) и тд. Это должно прсчитывать нек-рая ф-ция
                      //
                      //

                      border: TableBorder.all(),
                      defaultColumnWidth: FixedColumnWidth(120),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Значение Ik, A',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Среднее значение параметра P экземпляров множества n',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (int i = 0; i < lFactorPoints; i++)
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'I(k${i + 1})',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${rightColumnData[i]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    // SizedBox(height: 16),
                    // Text(
                    //   // Здесь должен выводиться результат функции по расчету формулы (3) вместо resultText
                    //   //
                    //   //

                    //   resultText,
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // //ы
                    // Column(

                    // ElevatedButton(
                    //   onPressed: () => _navigateToSecondPage(context),
                    //   child: Text('Перейти ко второй странице'),
                    // )),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '№ экземпляра выборки m, для которого отобразить формулу вида Pi = f (Ik):',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                      height: 4,
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    //
                    Text(
                      'Формула: $result',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateToThreePage(context),
                      child: Text('Перейти к третьей странице'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
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
    home: SecondAppDataFieldsTwoPage(title: 'Second App'),
    routes: {
      '/secondAppDatafieldsThree': (context) =>
          ThirdAppDataFields(title: 'Third App'),
    },
  ));
}

class ThirdAppDataFields extends StatelessWidget {
  final String title;

  const ThirdAppDataFields({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'This is the third app',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
