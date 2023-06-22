import 'package:flutter/material.dart';

class SecondApp extends StatefulWidget {
  const SecondApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SecondAppState createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String trainingSetVolume = '';
  String validationSetVolume = '';
  String btName = '';
  String lFactorPoints = '';
  FocusNode trainingSetFocusNode = FocusNode();
  FocusNode validationSetFocusNode = FocusNode();
  FocusNode btNameFocusNode = FocusNode();
  FocusNode lFactorPointsFocusNode = FocusNode();
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

  @override
  void dispose() {
    trainingSetFocusNode.dispose();
    validationSetFocusNode.dispose();
    btNameFocusNode.dispose();
    lFactorPointsFocusNode.dispose();
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
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        children: [
                          TextFormField(
                            focusNode: btNameFocusNode,
                            initialValue: btName,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {
                                btName = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Название БТ',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(trainingSetFocusNode);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
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
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Введите объем обучающей выборки n',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            onFieldSubmitted: (value) {
                              submitForm('training');
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
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
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Введите объем контрольной выборки m',
                              labelStyle: TextStyle(fontSize: 20),
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
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            focusNode: lFactorPointsFocusNode,
                            initialValue: lFactorPoints,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                lFactorPoints = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText:
                                  'Количество точек имитационного фактора l',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            onFieldSubmitted: (value) {
                              submitForm('lFactor');
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Зависимость параметра P i-го экземпляра объединенной выборки от тока коллектора Ik',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '№ экземпляра объединенной выборки',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 1; i <= factorPoints; i++)
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                      border: UnderlineInputBorder(),
                                      hintText: 'Ik ($i)',
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
                                  child: Text('$rowIndex'),
                                ),
                              ),
                              for (int columnIndex = 1;
                                  columnIndex <= factorPoints;
                                  columnIndex++)
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          if (columnIndex - 1 <
                                              tableData[rowIndex - 1].length) {
                                            tableData[rowIndex - 1]
                                                [columnIndex - 1] = value;
                                          }
                                        });
                                      },
                                      initialValue: tableData.isNotEmpty &&
                                              rowIndex - 1 < tableData.length &&
                                              columnIndex - 1 <
                                                  tableData[rowIndex - 1].length
                                          ? tableData[rowIndex - 1]
                                              [columnIndex - 1]
                                          : '',
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        hintText:
                                            'P${rowIndex} (Ik${columnIndex})',
                                      ),
                                    ),
                                  ),
                                ),
                            ],
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
  runApp(MaterialApp(
    title: 'Form Example',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: SecondApp(title: 'Form Example'),
  ));
}
