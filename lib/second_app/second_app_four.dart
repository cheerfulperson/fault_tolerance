import 'package:flutter/material.dart';
import '../routes.dart';
import 'components/header.dart';

void _navigateToFivePage(BuildContext context) {
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
  final _formKey = GlobalKey<FormState>();
  int validationSetFocusNode =
      10; // переменная из первой страницы, значение которой вводит пользователь с клавиатуры
  //в поле m, сейчас она для примера равна 10
  double averagePredictionError = 10;
  int numberM = 0;
  double calculationResult = 0;

  // остальной код остается без изменений

  @override
  Widget build(BuildContext context) {
    String resultText = 'Формула (5): $averagePredictionError';

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: 1020,
                height: MediaQuery.of(context).size.height - 160,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8.0,
                  ),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Таблица 6 - Зависимость параметра P i-го экземпляра объединенной выборки от наработки t',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                          Table(
                            // Таблица состоит из m+шапка строк, m есть переменная validationSetFocusNode
                            // первый столбец просто порядковые номера, второй столбе заполняется
                            // результатом работы функции по расчету формулы (2), третий
                            // столбец заполняется интерполяцией данных таблицы 4 (стр. 16 п.4 методы)
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '№ экземпляра объединенной выборки',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Прогнозное значение параметра Pпр(i)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Истинное  значение параметра Pист(i)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (int i = 1; i <= validationSetFocusNode; i++)
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        alignment: Alignment.center,
                                        child: Text('$i'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          alignment: Alignment.center,
                                          child: Text('Pпр $i'),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          alignment: Alignment.center,
                                          child: Text('Pист $i'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                numberM = int.tryParse(value) ?? 0;
                                calculationResult =
                                    averagePredictionError * numberM;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Введите значение для Number_m',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Результат: $averagePredictionError * $numberM = $calculationResult',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
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
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _navigateToFivePage(context),
                      child: Text('Перейти ко второй странице'),
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
