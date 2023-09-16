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
  late List<List<double?>> tableData;
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
    lFactorPoints = provider.lFactorPoints;
    trainingSetVolume = provider.trainingSetVolume;
    validationSetVolume = provider.validationSetVolume;
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
    final provider = context.watch<SecondAppProvider>();
    int result = 2 * n;
    String resultText = 'Результат: $result';
    int resultFour = 2;
    // Создание таблицы с заданными размерами
    tableData = provider.timeTableData;
    List<double> average = provider.getTimeAverage();

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
              width: 1220,
              height: MediaQuery.of(context).size.height - 160,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8.0,
                ),
                children: <Widget>[
                  // Здесь нужно добавить поле, в которое пользователь будет вводить количество заданных наработок t
                  // Т.е. Количество столбцев Таблицы 4 не совпадает со значением переменной l, а напрямую зависит
                  // от значения, которое пользователь введет в поле с названием
                  // "Количество точек наработки". Примечание под названием поля: Пожалуйста, введите
                  // число от 1 до 10
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Таблица 4 - Зависимость параметра P i-го экземпляра объединенной выборки от наработки t',
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '** Пожалуйста, заполните таблицу',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 4),

                  // Данные берутся из App 1
                  Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              height: 64,
                              alignment: Alignment.center,
                              child: Text(
                                '№ экземпляра объединенной выборки',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          for (int j = 0; j < tableData[0].length; j++)
                            TableCell(
                              child: Container(
                                height: 64,
                                alignment: Alignment.center,
                                child: SelectableText.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                        text:
                                            'Параметр P для заданной наработки t'),
                                    TextSpan(
                                        text: (j + 1).toString(),
                                        style: TextStyle(fontSize: 10)),
                                    TextSpan(text: ', ч'),
                                  ]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      for (int i = 0; i < tableData.length; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                child: SelectableText.rich(TextSpan(
                                  children: [
                                    TextSpan(
                                        text: (i + 1).toString(),
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                            for (int j = 0; j < tableData[0].length; j++)
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        tableData[i][j] = double.tryParse(
                                            value.replaceAll(',', '.'));
                                      });
                                    },
                                    initialValue: tableData[i].isNotEmpty
                                        ? (tableData[i][j] ?? '').toString()
                                        : '',
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '0.${i + 1}',
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
                      'Таблица 5 - Зависимость среднего значения P экземпляров обучающей выборки от наработки t',
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
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
                                'Среднее значение параметра P экземпляров обучающей выборки',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < average.length; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  't${i + 1}',
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
                                  (average[i] ?? 0).toStringAsFixed(3),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
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
