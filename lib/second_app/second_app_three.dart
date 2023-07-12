import 'package:flutter/material.dart';
import 'components/header.dart';
import '../routes.dart';

import 'components/nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/second_app_providers.dart';


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

  int runningTime = 0;
  int trainingSetVolume = 0;
  int validationSetVolume = 0;
  int lFactorPoints = 0;


  @override
  void initState() {
    super.initState();
    // Размеры таблицы

//     lFactorPoints =
//         Provider.of<SecondAppProvider>(context, listen: false).lFactorPoints;
// trainingSetVolume =
//         Provider.of<SecondAppProvider>(context, listen: false).trainingSetVolume;
// validationSetVolume =
//         Provider.of<SecondAppProvider>(context, listen: false).validationSetVolume;

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
    int sum = 0;
    int count = 0;

    // Расчет суммы и количества ячеек для среднего значения
    for (int i = validationSetVolume + 1;
        i <= trainingSetVolume + validationSetVolume;
        i++) {

      // sum += tableData[i][columnIndex];

      count++;
    }

    // Расчет среднего значения
    double average = sum / count;
    return average;
  }


// Нужно написать по расчету формулы (4) методы

  @override
  Widget build(BuildContext context) {
    int result = 2 * n;
    String resultText = 'Результат: $result';
    int resultFour = 2;

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
                      'Таблица 3 - Зависимость параметра P i-го экземпляра объединенной выборки от наработки  t',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),


                  // Данные берутся из App 1
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          for (int j = 0; j < lFactorPoints + 1; j++)
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  (j == 0)
                                      ? '№ экземпляра объединенной выборки'
                                      : 'Параметр P для заданной наработки t, ч',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      for (int i = 0;
                          i < trainingSetVolume + validationSetVolume + 1;
                          i++)
                        TableRow(
                          children: [
                            for (int j = 0; j < lFactorPoints + 1; j++)
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
                                                : 'Значение из App 1',

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

                      'Таблица 4 - Зависимость среднего значения P экземпляров множества n от наработки t',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Table(

                    // второй столбец рассчитываем по формуле (2), а третий столбец - методом линейной интерполяции таблицы 3.

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
                      for (int i = 1;
                          i <= trainingSetVolume + validationSetVolume;
                          i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30,
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
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  'P (t$i)',
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
                        '№ экземпляра из m, для которого отобразить формулу вида P = f2 (t)',
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
                              n = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    // Здесь должен отображаться результат работы функции по расчту формулы (4),
                    // resultText выводится для примера
                    '$resultText',
                    style: TextStyle(fontSize: 20, height: 1),
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => SecondAppProvider(),
      child: MaterialApp(
        title: 'Second App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SecondAppDataFieldsThreePage(title: 'Second App'),
        routes: {
          '/secondAppDatafieldsThree': (context) =>
              ThirdAppDataFields(title: 'Third App'),
        },
      ),
    ),
  );
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
