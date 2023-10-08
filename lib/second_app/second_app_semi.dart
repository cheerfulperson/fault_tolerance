import 'package:Method/utils/app_math.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'components/header.dart';
import 'components/nav_bar.dart';

import '../providers/second_app_providers.dart';

class SecondAppDataFieldsSemiPage extends StatefulWidget {
  const SecondAppDataFieldsSemiPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SecondAppDataFieldsSemiPageState createState() =>
      _SecondAppDataFieldsSemiPageState();
}

class _SecondAppDataFieldsSemiPageState
    extends State<SecondAppDataFieldsSemiPage> {
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
    currentFactor = provider.factorType;
  }

  FocusNode trainingSetFocusNode = FocusNode();
  FocusNode validationSetFocusNode = FocusNode();
  FocusNode btNameFocusNode = FocusNode();

  FocusNode lFactorPointsFocusNode = FocusNode();

  FocusNode mValueFocusNode = FocusNode();

  List<List<String>> validationTableData = [];

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
    final provider = context.watch<SecondAppProvider>();

    FactorString factorString = provider.getFactorNames();

    List<double?> deviceParams = provider.tableParams;
    List<String?> listFormulaParams = provider.listFormulaParams;

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText.rich(
                          TextSpan(children: [
                            TextSpan(
                                text:
                                    'Таблица 2 - Полученная  зависимость параметра P i-го экземпляра объединенной выборки от фактора ${factorString.fullName.toLowerCase()} '),
                            TextSpan(text: factorString.symbol.fullName),
                            TextSpan(
                                text: factorString.symbol.shortName,
                                style: TextStyle(fontSize: 14)),
                          ]),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '** Для корректной работы программы, пожалуйста, заполните таблицу',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(TextSpan(
                            text:
                                '** Поддерживаемые функции и операторы для формул: ${supportedFunctions.join(' , ')}')),
                        SizedBox(
                          height: 8,
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
                                    TableCell(
                                        child: Container(
                                      height: 72,
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
                                    )),
                                    TableCell(
                                      child: Container(
                                        height: 72,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(width: 1),
                                                bottom: BorderSide(width: 1),
                                                right: BorderSide(width: 1))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SelectableText.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      'Формула зависимости P от ${factorString.shortName.toLowerCase()} '),
                                              TextSpan(
                                                  text: factorString
                                                      .symbol.fullName),
                                              TextSpan(
                                                  text: factorString
                                                      .symbol.shortName,
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              TextSpan(
                                                  text: 'i',
                                                  style:
                                                      TextStyle(fontSize: 8)),
                                              TextSpan(
                                                  text:
                                                      ', ${provider.measurement}'),
                                            ]),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                for (int index = 0;
                                    index < listFormulaParams.length;
                                    index++)
                                  TableRow(
                                    children: [
                                      TableCell(
                                          child: Container(
                                        height: 72,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                left: BorderSide(width: 1),
                                                bottom: BorderSide(width: 1),
                                                right: BorderSide(width: 1))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Text(
                                              (index + 1).toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      TableCell(
                                          child: Container(
                                        height: 72,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(width: 1),
                                                right: BorderSide(width: 1))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                listFormulaParams[index] =
                                                    value;
                                              });
                                            },
                                            initialValue:
                                                deviceParams.isNotEmpty
                                                    ? listFormulaParams[index]
                                                            ?.toString() ??
                                                        ''
                                                    : '',
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  '0.25 * ln(2 * x^2 + 0.23)',
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  )
                              ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
