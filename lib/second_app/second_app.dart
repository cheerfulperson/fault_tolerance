import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'components/header.dart';
import '../routes.dart';
import 'components/nav_bar.dart';

import '../providers/second_app_providers.dart';


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


// Переключатель
enum FactorType {
  CollectorCurrent,
  Temperature,
  CollectorEmitterVoltage,
}

class _SecondAppDataFieldsOnePageState
    extends State<SecondAppDataFieldsOnePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _trainingSetVolumeController =
      TextEditingController();
  final TextEditingController _validationSetVolumeController =
      TextEditingController();
  final TextEditingController _lFactorPointsController =
      TextEditingController();
  FactorType currentFactor = FactorType.CollectorCurrent;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SecondAppProvider>(context, listen: false);
    _trainingSetVolumeController.text = provider.trainingSetVolume;
    _validationSetVolumeController.text = provider.validationSetVolume;
    _lFactorPointsController.text = provider.lFactorPoints;
  }

  String trainingSetVolume = '';
  String validationSetVolume = '';
  String btName = '';
  String lFactorPoints = '';
  String resultLFactorPoints = '';
  String resultTrainingSetVolume = '';
  String resultValidationSetVolume = '';


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

//Функция, которая должна рассчитывать формулу (2) методы для экземпляра из множества m.
//Сейчас она  рассчитывает понос, это для примера
  void calculateResult(String value) {
    setState(() {
      lFactorPoints = value;
      trainingSetVolume = _trainingSetVolumeController
          .text; // Обновляем переменную trainingSetVolume
      validationSetVolume = _validationSetVolumeController
          .text; // Обновляем переменную validationSetVolume
      int mValue = int.tryParse(value) ?? 0;
      double calculation = mValue * 2;
      resultLFactorPoints = calculation.toStringAsFixed(2);
      resultTrainingSetVolume = calculation.toStringAsFixed(2);
      resultValidationSetVolume = calculation.toStringAsFixed(2);

    });
  }

  @override
  void dispose() {
    _trainingSetVolumeController.dispose();
    _validationSetVolumeController.dispose();
    _lFactorPointsController.dispose();
    btNameFocusNode.dispose();

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
                                'Имитационный фактор F:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 4),
                              ToggleButtons(
                                isSelected: [
                                  currentFactor == FactorType.CollectorCurrent,
                                  currentFactor == FactorType.Temperature,
                                  currentFactor ==
                                      FactorType.CollectorEmitterVoltage,
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    if (index == 0) {
                                      currentFactor =
                                          FactorType.CollectorCurrent;
                                    } else if (index == 1) {
                                      currentFactor = FactorType.Temperature;
                                    } else if (index == 2) {
                                      currentFactor =
                                          FactorType.CollectorEmitterVoltage;
                                    }
                                  });
                                },
                                children: [
                                  Text(
                                    ' Ток коллектора ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    ' Температура ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    ' Напряжение коллектор-эмиттер ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
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
                                'Название прибора, который будет участвовать в эксперименте:',
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
                                    validationSetFocusNode.dispose();

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
                                  controller: _trainingSetVolumeController,
                                  onChanged: (value) {
                                    setState(() {
                                      final provider =
                                          Provider.of<SecondAppProvider>(
                                              context,
                                              listen: false);
                                      provider.setTrainingSetVolume(value);
                                      calculateResult(
                                          value); // Вызываем функцию calculateResult при изменении значения
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
                                  controller: _validationSetVolumeController,
                                  onChanged: (value) {
                                    setState(() {
                                      final provider =
                                          Provider.of<SecondAppProvider>(
                                              context,
                                              listen: false);
                                      provider.setValidationSetVolume(value);
                                      calculateResult(
                                          value); // Вызываем функцию calculateResult при изменении значения
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
                                  controller: _lFactorPointsController,
                                  onChanged: (value) {
                                    setState(() {
                                      final provider =
                                          Provider.of<SecondAppProvider>(
                                              context,
                                              listen: false);
                                      provider.setLFactorPoints(value);
                                      calculateResult(
                                          value); // Вызываем функцию calculateResult при изменении значения
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
// Начало

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
                                        child: SizedBox(
                                          width: 72,
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
                                    ),
                                    for (int i = 1; i <= factorPoints; i++)
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 72,
                                            child: Text(
                                              'Параметр P при значении тока Ik',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
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
                                                  if (i - 1 <
                                                      tableData[0].length) {
                                                    tableData[0][i - 1] = value;
                                                  }
                                                });
                                              },
                                              initialValue: tableData.isNotEmpty
                                                  ? tableData[0][i - 1]
                                                  : '',
                                              keyboardType:
                                                  TextInputType.number,
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
                                    rowIndex <= trainingSet + validationSet + 0;
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                      tableData[rowIndex - 1][
                                                              columnIndex - 1] =
                                                          value;
                                                    }
                                                  });
                                                },
                                                initialValue: tableData
                                                            .isNotEmpty &&
                                                        rowIndex - 1 <
                                                            tableData.length &&
                                                        columnIndex - 1 <
                                                            tableData[rowIndex -
                                                                    1]
                                                                .length
                                                    ? tableData[rowIndex - 1]
                                                        [columnIndex - 1]
                                                    : '',
                                                keyboardType:
                                                    TextInputType.number,
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
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 720,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 16,
                                  height: 4,
                                ),
                                SizedBox(
                                  width: 720,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '№ экземпляра из m, для которого отобразить формулу вида Pi = f (Ik):',
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
                                        style:
                                            TextStyle(fontSize: 20, height: 1),
                                        decoration: InputDecoration(
                                          border:
                                              OutlineInputBorder(gapPadding: 2),
                                          hintText: '1',
                                          hintStyle: TextStyle(fontSize: 20),
                                          labelStyle: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
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
                          Text(
                            'Формула: $resultLFactorPoints',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
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
