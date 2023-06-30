import 'package:flutter/material.dart';
import 'components/header.dart';
import '../routes.dart';

void _navigateToTwoPage(BuildContext context) {
  Navigator.pushNamed(
    context,
    secondAppDatafields,
  );
}

class SecondAppDataFieldsOnePage extends StatefulWidget {
  const SecondAppDataFieldsOnePage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SecondAppDataFieldsOnePageState createState() =>
      _SecondAppDataFieldsOnePageState();
}

class _SecondAppDataFieldsOnePageState
    extends State<SecondAppDataFieldsOnePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String trainingSetVolume = ''; // множество n
  String validationSetVolume = ''; // множество m
  String btName = '';
  String lFactorPoints = ''; // количество точек имитационного фактора
  String result = '';

  FocusNode trainingSetFocusNode = FocusNode();
  FocusNode validationSetFocusNode = FocusNode();
  FocusNode btNameFocusNode = FocusNode();
  FocusNode lFactorPointsFocusNode = FocusNode();
  FocusNode mValueFocusNode = FocusNode();

  List<List<String>> tableData = [];
  List<List<String>> validationTableData = [];

  void submitForm(String value) {
    if (_formKey.currentState!.validate()) {
      if (value == 'training') {
        print('Training Set Volume: $trainingSetVolume');
      } else if (value == 'validation') {
        print('Validation Set Volume: $validationSetVolume');
      } else if (value == 'lFactor') {
        print('L Factor Points: $lFactorPoints');
      }
    }
  }

//Функция, которая должна рассчитывать формулу (2) для экземпляра из множества m (переменная trainingSetFocusNode). Сейчас она  рассчитывает понос, это для примера
  void calculateResult(String value) {
    setState(() {
      int mValue = int.tryParse(value) ?? 0;
      double calculation = mValue * 2;
      result = calculation.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    trainingSetFocusNode.dispose();
    validationSetFocusNode.dispose();
    btNameFocusNode.dispose();
    lFactorPointsFocusNode.dispose();
    mValueFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    int trainingSet = int.tryParse(trainingSetVolume) ?? 0;
    int validationSet = int.tryParse(validationSetVolume) ?? 0;
    int factorPoints = int.tryParse(lFactorPoints) ?? 0;

    tableData = List.generate(
      trainingSet + validationSet,
      (_) => List<String>.filled(factorPoints, ''),
    );

    validationTableData = List.generate(
      validationSet,
      (_) => List<String>.filled(2, ''),
    );

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
                    Form(
                      key: _formKey,
                      child: Column(
                        // Помогло
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Название прибора, который будет учавствовать в эксперементе:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  focusNode: btNameFocusNode,
                                  initialValue: btName,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      btName = value;
                                    });
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: 'КТ872А',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 20),
                                  ),
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(trainingSetFocusNode);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Объём обучающей выборки n:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  focusNode: trainingSetFocusNode,
                                  initialValue: trainingSetVolume,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '0') {
                                      return 'Пожалуйста введите число больше нуля';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      trainingSetVolume = value;
                                    });
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '10',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
                                  onFieldSubmitted: (value) {
                                    submitForm('training');
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Объём контрольной выборки m:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  focusNode: validationSetFocusNode,
                                  initialValue: validationSetVolume,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '0') {
                                      return 'Пожалуйста введите число больше нуля';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      validationSetVolume = value;
                                    });
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '10',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      validationTableData = List.generate(
                                        int.tryParse(value) ?? 0,
                                        (_) => List<String>.filled(2, ''),
                                      );
                                    });
                                    submitForm('validation');
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Количество точек имитационного фактора l:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  focusNode: lFactorPointsFocusNode,
                                  initialValue: lFactorPoints,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      lFactorPoints = value;
                                    });
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '5',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
                                  onFieldSubmitted: (value) {
                                    submitForm('lFactor');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Таблица 1 - Зависимость параметра P i-го экземпляра объединенной выборки от тока коллектора Ik',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    Container(
                        child: Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '№ экземпляра объединенной выборки',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 1; i <= factorPoints; i++)
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 72,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          if (i - 1 < tableData[0].length) {
                                            tableData[0][i - 1] = value;
                                          }
                                        });
                                      },
                                      initialValue: tableData.isNotEmpty
                                          ? tableData[0][i - 1]
                                          : '',
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Ik ($i)',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        for (int rowIndex = 1;
                            rowIndex <= trainingSet + validationSet;
                            rowIndex++)
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          '$rowIndex',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              for (int columnIndex = 1;
                                  columnIndex <= factorPoints;
                                  columnIndex++)
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 72,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            if (columnIndex - 1 <
                                                tableData[rowIndex - 1]
                                                    .length) {
                                              tableData[rowIndex - 1]
                                                  [columnIndex - 1] = value;
                                            }
                                          });
                                        },
                                        initialValue: tableData.isNotEmpty &&
                                                rowIndex - 1 <
                                                    tableData.length &&
                                                columnIndex - 1 <
                                                    tableData[rowIndex - 1]
                                                        .length
                                            ? tableData[rowIndex - 1]
                                                [columnIndex - 1]
                                            : '',
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText:
                                              'P$rowIndex (Ik$columnIndex)',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    )),

                    const SizedBox(height: 16),
                    Container(
                      width: 720,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '№ экземпляра выборки m, для которого отобразить формулу вида Pi = f (Ik):',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            width: 16,
                            height: 4,
                          ),
                          TextFormField(
                            focusNode: mValueFocusNode,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              calculateResult(value);
                            },
                            style: TextStyle(fontSize: 20, height: 1),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(gapPadding: 2),
                              hintText: '1',
                              hintStyle: TextStyle(fontSize: 20),
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
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

                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _navigateToTwoPage(context),
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
