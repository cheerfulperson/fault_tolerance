import 'package:Method/first_app/components/header.dart';
import 'package:Method/first_app/components/nav_bar.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/display_param.dart';

class FirstAppCenteredValues extends StatefulWidget {
  const FirstAppCenteredValues({super.key, required this.title});
  final String title;

  @override
  State<FirstAppCenteredValues> createState() => _FirstAppCenteredValuesState();
}

class _FirstAppCenteredValuesState extends State<FirstAppCenteredValues> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FirstAppNavBar(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                    width: 1180,
                    height: screenHeight - 160,
                    child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8.0,
                        ),
                        children: [
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Таблица 3 - Центры классов K'),
                                  TextSpan(
                                      text: '1',
                                      style: TextStyle(fontSize: 12)),
                                  TextSpan(text: ' и K'),
                                  TextSpan(
                                      text: '2',
                                      style: TextStyle(fontSize: 12)),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DisplayTableData(),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Таблица 4 - Условия получения кодовых сигналов для параметров'),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DisplayCentersTableData()
                        ])))
          ],
        ),
      ),
    );
  }
}

class DisplayTableData extends StatefulWidget {
  const DisplayTableData({
    super.key,
  });

  @override
  State<DisplayTableData> createState() => _DisplayTableDataState();
}

class _DisplayTableDataState extends State<DisplayTableData> {
  List<String> getK1Params() {
    List<DeviceParams> deviceParams =
        context.watch<FirstAppProvider>().deviceParams;
    List<FO> k1 = context
        .watch<FirstAppProvider>()
        .deviceFOs
        .where((element) => element.number == '1')
        .toList();
    return deviceParams.map<String>((e) {
      double value = 0.0;
      k1.forEach((element) {
        try {
          value += double.parse(element.params
              .where((element) => element.paramId == e.id)
              .first
              .value);
        } catch (e) {
          //no
        }
      });
      return (value / k1.length).toStringAsFixed(4);
    }).toList();
  }

  List<String> getK0Params() {
    List<DeviceParams> deviceParams =
        context.watch<FirstAppProvider>().deviceParams;
    List<FO> k0 = context
        .watch<FirstAppProvider>()
        .deviceFOs
        .where((element) => element.number == '0')
        .toList();
    return deviceParams.map<String>((e) {
      double value = 0.0;
      k0.forEach((element) {
        try {
          value += double.parse(element.params
              .where((element) => element.paramId == e.id)
              .first
              .value);
        } catch (e) {
          //no
        }
      });
      return (value / k0.length).toStringAsFixed(4);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(240),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Container(
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        top: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('Искомая характеристика',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                )),
                child: Column(children: [
                  Container(
                    height: 31,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: 'Информативный параметр X'),
                      TextSpan(text: 'i', style: TextStyle(fontSize: 12))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                  ),
                  Parameters()
                ]),
              ),
            ]),
            TableRow(children: [
              Container(
                  height: 32,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1))),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Центр класса K'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 8)),
                    TextSpan(text: ': m'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 8)),
                    TextSpan(text: '(x'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 8)),
                    TextSpan(text: ')'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)))),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        right: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: ValuesList(parameters: getK1Params()),
              ),
            ]),
            TableRow(children: [
              Container(
                  height: 32,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1))),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Центр класса K'),
                          TextSpan(text: '0', style: TextStyle(fontSize: 8)),
                          TextSpan(text: ': m'),
                          TextSpan(text: '0', style: TextStyle(fontSize: 8)),
                          TextSpan(text: '(x'),
                          TextSpan(text: 'i', style: TextStyle(fontSize: 8)),
                          TextSpan(text: ')'),
                        ],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ))),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        right: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: ValuesList(parameters: getK0Params()),
              ),
            ])
          ],
        ),
      ],
    );
  }
}

class Parameters extends StatelessWidget {
  Parameters({
    super.key,
  });

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 31,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1),
      )),
      child: Row(
        children:
            context.watch<FirstAppProvider>().deviceParams.map<Widget>((e) {
          index += 1;
          return Expanded(
              child: Container(
                  height: 31,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  constraints: BoxConstraints(maxWidth: 240),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: index ==
                                      context
                                          .watch<FirstAppProvider>()
                                          .deviceParams
                                          .length
                                  ? 0
                                  : 1))),
                  child: DisplayParam(
                    param: e,
                  )));
        }).toList(),
      ),
    ));
  }
}

class ValuesList extends StatelessWidget {
  ValuesList({
    super.key,
    required this.parameters,
  });

  List<String> parameters;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: parameters.map<Widget>((e) {
        index++;
        return Expanded(
            child: Container(
                height: 31,
                padding: EdgeInsets.symmetric(horizontal: 8),
                constraints: BoxConstraints(maxWidth: 240),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: index == parameters.length ? 0 : 1))),
                child: Text(
                  e,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )));
      }).toList(),
    );
  }
}

class DisplayCentersTableData extends StatefulWidget {
  const DisplayCentersTableData({
    super.key,
  });

  @override
  State<DisplayCentersTableData> createState() => _DisplayCentersTableData();
}

class _DisplayCentersTableData extends State<DisplayCentersTableData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(240),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Container(
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        top: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('Информативный параметр',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              Container(
                height: 64,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                )),
                child: Column(children: [
                  Container(
                    height: 31,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1))),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: 'Условие получения кодового сигнала'),
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                  ),
                  Container(
                    height: 31,
                    alignment: Alignment.center,
                    child: Row(children: [
                      Expanded(
                          child: Container(
                        height: 31,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        constraints: BoxConstraints(maxWidth: 240),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1))),
                        child: Text(
                          'τ = 1',
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        height: 31,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        constraints: BoxConstraints(maxWidth: 240),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1))),
                        child: Text(
                          'τ = R',
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        height: 31,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        constraints: BoxConstraints(maxWidth: 240),
                        alignment: Alignment.center,
                        child: Text(
                          'τ = 0',
                          style: TextStyle(fontSize: 18),
                        ),
                      ))
                    ]),
                  ),
                ]),
              ),
            ]),
            ...context
                .watch<FirstAppProvider>()
                .deviceParams
                .map((e) => TableRow(children: [
                      Container(
                          height: 32,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1))),
                          child: DisplayParam(
                            param: e,
                          )),
                      Container(
                          height: 32,
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(width: 1),
                                  right: BorderSide(width: 1),
                                  bottom: BorderSide(width: 1))),
                          child: Condition(param: e)),
                    ]))
                .toList()
          ],
        ),
      ],
    );
  }
}

class Condition extends StatelessWidget {
  Condition({
    super.key,
    required this.param,
  });

  DeviceParams param;
  @override
  Widget build(BuildContext context) {
    CenteredValue centeredValue =
        context.watch<FirstAppProvider>().getCenteredValues(param.id);
    bool isK1Bigger = false;
    try {
      isK1Bigger =
          double.parse(centeredValue.k1) > double.parse(centeredValue.k0);
    } catch (e) {}
    return Row(children: [
      Expanded(
          child: Container(
              height: 31,
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 240),
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(width: 1),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayParam(param: param, withoutUnit: true),
                  Text(
                    isK1Bigger ? ' > ' : ' < ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    centeredValue.k1,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ))),
      Expanded(
          child: Container(
              height: 31,
              padding: EdgeInsets.symmetric(horizontal: 6),
              constraints: BoxConstraints(maxWidth: 240),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: isK1Bigger
                    ? [
                        Text(
                          centeredValue.k0,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          ' ≤ ',
                          style: TextStyle(fontSize: 18),
                        ),
                        DisplayParam(param: param, withoutUnit: true),
                        Text(
                          ' ≤ ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          centeredValue.k1,
                          style: TextStyle(fontSize: 18),
                        )
                      ]
                    : [
                        Text(
                          centeredValue.k1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          ' ≤ ',
                          style: TextStyle(fontSize: 18),
                        ),
                        DisplayParam(param: param, withoutUnit: true),
                        Text(
                          ' ≤ ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          centeredValue.k0,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
              ))),
      Expanded(
          child: Container(
              height: 31,
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 240),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DisplayParam(param: param, withoutUnit: true),
                  Text(
                    !isK1Bigger ? ' > ' : ' < ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    centeredValue.k0,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ))),
    ]);
  }
}
