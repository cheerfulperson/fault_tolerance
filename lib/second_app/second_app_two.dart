import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes.dart';
import 'components/header.dart';
import 'components/nav_bar.dart';
import '../providers/second_app_providers.dart';

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

  int lFactorPointsShow = 10; // Added variable for user input

// Нужно создать функцию расчета формулы (3) методы
  //
  //

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SecondAppProvider>(context, listen: false);
    lFactorPoints = provider.lFactorPoints;
  }

  // Нужно создать функцию расчета формулы (3)
  //
  //

  @override
  Widget build(BuildContext context) {
    int result = 2 * n;
    String resultText = 'Результат: $result';
    double screenHeight = MediaQuery.of(context).size.height;
    final provider = context.watch<SecondAppProvider>();
    List<double> tableData = provider.getAverage();
    FactorString factorString = provider.getFactorNames();

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: <Widget>[
            SecondAppNavBar(),
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
                      'Таблица 3 - Зависимость среднего значения параметра P экземпляров обучающей выборки от имитационного фактора ${factorString.fullName.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
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
                                  child: SelectableText.rich(
                                    TextSpan(children: [
                                      TextSpan(text: 'Значение '),
                                      TextSpan(
                                          text: factorString.symbol.fullName),
                                      TextSpan(
                                          text: factorString.symbol.shortName,
                                          style: TextStyle(fontSize: 14)),
                                    ]),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
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
                                    'Среднее значение параметра P экземпляров обучающей выборки',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SelectableText.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: factorString.symbol.fullName),
                                        TextSpan(
                                            text: factorString.symbol.shortName,
                                            style: TextStyle(fontSize: 12)),
                                        TextSpan(
                                            text: '${i + 1}',
                                            style: TextStyle(fontSize: 12))
                                      ]),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
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
                                      tableData[i].toStringAsFixed(3),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Здесь должен выводиться результат функции по расчету формулы (3) вместо resultText
                    //
                    //

                    // ... (other parts of the code)

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Математическая модель зависимости среднего значения параметра P экземпляров обучающей выборки от фактора ${factorString.fullName.toLowerCase()}:', // Replace with the desired text
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '** Пожалуйста, ведите математическую модель зависимости',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          width: 720, // Set the width of the input field to 720
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, height: 1),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(gapPadding: 2),
                              hintText: '0.23 * (cos(x) + 0.24)',
                              hintStyle: TextStyle(fontSize: 20),
                              labelStyle: TextStyle(fontSize: 2),
                            ),
                            initialValue: provider.secondFormula,
                            onChanged: (value) {
                              provider.setSecondFormula(value);
                            },
                          ),
                        ),
                      ],
                    ),
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
  runApp(
    ChangeNotifierProvider(
      create: (context) => SecondAppProvider(),
      child: MaterialApp(
        title: 'Second App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SecondAppDataFieldsTwoPage(title: 'Second App'),
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
