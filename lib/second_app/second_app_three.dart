import 'package:flutter/material.dart';
import 'components/header.dart';
import '../routes.dart';

void _navigateToFourPage(BuildContext context) {
  Navigator.pushNamed(
    context,
    secondAppDatafieldsFourPage,
  );
}

class SecondAppDataFieldsThreePage extends StatefulWidget {
  final String title;

  const SecondAppDataFieldsThreePage({Key? key, required this.title})
      : super(key: key);

  @override
  _SecondAppDataFieldsThreePageState createState() =>
      _SecondAppDataFieldsThreePageState();
}

class _SecondAppDataFieldsThreePageState
    extends State<SecondAppDataFieldsThreePage> {
  late List<List<int>> tableData;
  late List<int> rightColumnData;
  int n = 0;

  @override
  void initState() {
    super.initState();
    // Размеры таблицы
    int lFactorPoints = 5;
    int trainingSetVolume = 2;
    int validationSetVolume = 2;

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

    // Заполнение числами в ячейках
    for (int i = 1; i <= validationSetVolume; i++) {
      for (int j = 1; j <= lFactorPoints; j++) {
        tableData[i][j] = int.parse('${j}${i}');
      }
    }

    for (int i = validationSetVolume + 1;
        i <= trainingSetVolume + validationSetVolume;
        i++) {
      for (int j = 1; j <= lFactorPoints; j++) {
        tableData[i][j] = int.parse('${j}${i - validationSetVolume}');
      }
    }

    // Заполнение правого столбца числами
    rightColumnData = List.generate(
      trainingSetVolume + validationSetVolume,
      (index) => index + 1,
    );
  }

  double calculateAverage(int columnIndex) {
    int lFactorPoints = 5;
    int trainingSetVolume = 2;
    int validationSetVolume = 2;
    int sum = 0;
    int count = 0;

    // Расчет суммы и количества ячеек для среднего значения
    for (int i = validationSetVolume + 1;
        i <= trainingSetVolume + validationSetVolume;
        i++) {
      sum += tableData[i][columnIndex];
      count++;
    }

    // Расчет среднего значения
    double average = sum / count;
    return average;
  }

  @override
  Widget build(BuildContext context) {
    int result = 2 * n;
    String resultText = 'Результат: $result';
    int resultFour = 2;

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'Таблица 4 - Зависимость параметра P i-го экземпляра объединенной выборки от наработки  t',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Table(
                    // Ячейки с числами 11, 12, 13, 21, 22, 23 и тд нужно заполнить функцией по расчету формулы (3)
                    //
                    //
                    //

                    border: TableBorder.all(),
                    children: [
                      for (int i = 0; i < tableData.length; i++)
                        TableRow(
                          children: [
                            for (int j = 0; j < tableData[i].length; j++)
                              TableCell(
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    (i == 0 && j == 0)
                                        ? ''
                                        : (i == 0)
                                            ? 't${tableData[i][j]}'
                                            : (j == 0)
                                                ? '${tableData[i][j]}'
                                                : '${tableData[i][j]}',
                                    style: TextStyle(
                                      fontWeight: (i == 0 || j == 0)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Таблица 5 - Зависимость среднего значения P экземпляров множества n от наработки t',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Table(
                    // В ячейках левого и правого столбцах должны выводиться числа в соответствии
                    // с FirstApp
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
                                'Среднее значение параметра P экземпляров множества n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 1; i <= 5; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30, // Обновленная высота ячеек
                                alignment: Alignment.center,
                                child: Text(
                                  't$i',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30, // Обновленная высота ячеек
                                alignment: Alignment.center,
                                child: Text(
                                  '${calculateAverage(i)}',
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  // SizedBox(height: 20),
                  // Text(
                  //   // Тут должен выводиться результат функции по расчету формулы (4)
                  //   //
                  //   //
                  //   //

                  //   'Формула: $resultFour',
                  //   style: TextStyle(fontSize: 20),
                  // ),
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

                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToFourPage(context),
                    child: Text('Перейти к четвертой странице'),
                  ),
                  SizedBox(height: 16),
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
    home: SecondAppDataFieldsThreePage(title: 'Second App'),
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
