import 'package:Method/first_app/first_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    String volumeTraining = provider.trainingSetVolume.toString();
    String volumeValidation = provider.validationSetVolume.toString();
    String factor = provider.lFactorPoints.toString();

    _trainingSetVolumeController.value =
        _trainingSetVolumeController.value.copyWith(
      text: volumeTraining,
      selection: TextSelection(
          baseOffset: volumeTraining.length,
          extentOffset: volumeTraining.length),
      composing: TextRange.empty,
    );
    _validationSetVolumeController.value =
        _validationSetVolumeController.value.copyWith(
      text: volumeValidation,
      selection: TextSelection(
          baseOffset: volumeValidation.length,
          extentOffset: volumeValidation.length),
      composing: TextRange.empty,
    );
    _lFactorPointsController.value = _lFactorPointsController.value.copyWith(
      text: factor,
      selection:
          TextSelection(baseOffset: factor.length, extentOffset: factor.length),
      composing: TextRange.empty,
    );
    btName = provider.deviceName;
    currentFactor = provider.factorType;
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
    final provider = Provider.of<SecondAppProvider>(context, listen: false);

    int trainingSet = provider.trainingSetVolume;
    int validationSet = provider.validationSetVolume;
    int factorPoints = provider.lFactorPoints;
    FactorString factorString = provider.getFactorNames();

    // tableData = List.generate(
    //   trainingSet + validationSet,
    //   (_) => List<String>.filled(factorPoints, ''),
    // );

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: <Widget>[
            SecondAppNavBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: 1280,
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
                                borderWidth: 2,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                                    Provider.of<SecondAppProvider>(context,
                                            listen: false)
                                        .setFactorType(currentFactor);
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
                                    Provider.of<SecondAppProvider>(context,
                                            listen: false)
                                        .setDeviceName(value);
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
                                '** Общий объём выборки N включает обучающую выборку размером n и \nконтрольную выборку размеров m',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Объём обучающей выборки n:',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  controller: _trainingSetVolumeController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericalRangeFormatter(max: 1000, min: 1)
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      try {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setTrainingSetVolume(
                                                int.parse(value));
                                      } catch (e) {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setTrainingSetVolume(2);
                                      }
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericalRangeFormatter(max: 1000, min: 1)
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      try {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setValidationSetVolume(
                                                int.parse(value));
                                      } catch (e) {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setValidationSetVolume(5);
                                      }
                                    });
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '10',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    NumericalRangeFormatter(max: 7, min: 1)
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      try {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setLFactorPoints(int.parse(value));
                                      } catch (e) {
                                        Provider.of<SecondAppProvider>(context,
                                                listen: false)
                                            .setLFactorPoints(2);
                                      }
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
                              SelectableText.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'Таблица 1 - Зависимость параметра P i-го экземпляра объединенной выборки от ${factorString.fullName.toLowerCase()} '),
                                  TextSpan(text: factorString.symbol.fullName),
                                  TextSpan(
                                      text: factorString.symbol.shortName,
                                      style: TextStyle(fontSize: 14)),
                                ]),
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
                          Text(
                            '**Первый(е) $trainingSet строк(и) таблицы есть элемент(ы) выборки n, остальные строки - элементы выборки m',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(180),
                                1: FlexColumnWidth(),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      height: 158,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(width: 1),
                                              bottom: BorderSide(width: 1),
                                              top: BorderSide(width: 1),
                                              right: BorderSide(width: 1))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          child: Text(
                                            '№ экземпляра объединенной выборки',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 158,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(width: 1),
                                              bottom: BorderSide(width: 1),
                                              right: BorderSide(width: 1))),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            for (int i = 1;
                                                i <= factorPoints;
                                                i++)
                                              Expanded(
                                                  child: Container(
                                                height: 93,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 1))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SelectableText.rich(
                                                    TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'Параметр P при значении ${factorString.shortName.toLowerCase()} '),
                                                      TextSpan(
                                                          text: factorString
                                                              .symbol.fullName),
                                                      TextSpan(
                                                          text: factorString
                                                              .symbol.shortName,
                                                          style: TextStyle(
                                                              fontSize: 10)),
                                                      TextSpan(
                                                          text: '$i',
                                                          style: TextStyle(
                                                              fontSize: 8))
                                                    ]),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          ]),
                                          Row(
                                            children: [
                                              for (int i = 1;
                                                  i <= factorPoints;
                                                  i++)
                                                Expanded(
                                                    child: Container(
                                                  height: 63,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              width: 1),
                                                          right:
                                                              i != factorPoints
                                                                  ? BorderSide(
                                                                      width: 1)
                                                                  : BorderSide
                                                                      .none)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: 72,
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            if (i - 1 <
                                                                tableData[0]
                                                                    .length) {
                                                              tableData[0]
                                                                      [i - 1] =
                                                                  value;
                                                            }
                                                          });
                                                        },
                                                        initialValue:
                                                            tableData.isNotEmpty
                                                                ? tableData[0]
                                                                    [i - 1]
                                                                : '',
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText: '0.$i',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                for (int rowIndex = 1;
                                    rowIndex <= trainingSet + validationSet;
                                    rowIndex++)
                                  TableRow(
                                    children: [
                                      Container(
                                        height: 64,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(width: 1),
                                                bottom: BorderSide(width: 1),
                                                right: BorderSide(width: 1))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '$rowIndex',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            for (int columnIndex = 1;
                                                columnIndex <= factorPoints;
                                                columnIndex++)
                                              Expanded(
                                                  child: Container(
                                                height: 64,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1),
                                                        right: BorderSide(
                                                            width: 1))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 72,
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (columnIndex - 1 <
                                                              tableData[
                                                                      rowIndex -
                                                                          1]
                                                                  .length) {
                                                            tableData[rowIndex -
                                                                    1][
                                                                columnIndex -
                                                                    1] = value;
                                                          }
                                                        });
                                                      },
                                                      initialValue: tableData
                                                                  .isNotEmpty &&
                                                              rowIndex - 1 <
                                                                  tableData
                                                                      .length &&
                                                              columnIndex - 1 <
                                                                  tableData[
                                                                          rowIndex -
                                                                              1]
                                                                      .length
                                                          ? tableData[
                                                                  rowIndex - 1]
                                                              [columnIndex - 1]
                                                          : '',
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: '0',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          ],
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
                                      SelectableText.rich(
                                        TextSpan(children: [
                                          TextSpan(text: 'Формула вида P'),
                                          TextSpan(
                                              text: 'i',
                                              style: TextStyle(fontSize: 14)),
                                          TextSpan(text: ' = f ('),
                                          TextSpan(
                                              text:
                                                  factorString.symbol.fullName),
                                          TextSpan(
                                              text:
                                                  factorString.symbol.shortName,
                                              style: TextStyle(fontSize: 14)),
                                          TextSpan(text: '):'),
                                        ]),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                        height: 4,
                                      ),
                                      TextFormField(
                                        focusNode: mValueFocusNode,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {},
                                        style:
                                            TextStyle(fontSize: 20, height: 1),
                                        decoration: InputDecoration(
                                          border:
                                              OutlineInputBorder(gapPadding: 2),
                                          hintText:
                                              '0.25 * ln(0.12 * x^2 + 0.34)',
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
