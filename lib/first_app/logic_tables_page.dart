import 'package:Method/first_app/components/header.dart';
import 'package:Method/first_app/components/nav_bar.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/utils/pdf/make_pdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogicTablesPage extends StatefulWidget {
  const LogicTablesPage({super.key, required this.title});
  final String title;

  @override
  State<LogicTablesPage> createState() => _LogicTablesPageState();
}

class _LogicTablesPageState extends State<LogicTablesPage> {
  int currentResult = 0;

  List<Widget> showResults(
      BuildContext context, List<FO> devicesF1, List<FO> devicesF0) {
    if (currentResult == 0) {
      return [
        SelectableText.rich(
          TextSpan(children: [
            TextSpan(
                text:
                    'Таблица 9 - Модель прогнозирования в виде логической таблицы для класса K'),
            TextSpan(text: '1', style: TextStyle(fontSize: 12)),
          ], style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        const SizedBox(
          height: 4,
        ),
        DisplayLogicTableData(
          deviceFOs: devicesF1,
        )
      ];
    }
    if (currentResult == 1) {
      return [
        SelectableText.rich(
          TextSpan(children: [
            TextSpan(
                text:
                    'Таблица 9 - Модель прогнозирования в виде логической таблицы для класса K'),
            TextSpan(text: '2', style: TextStyle(fontSize: 12)),
          ], style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        const SizedBox(
          height: 4,
        ),
        DisplayLogicTableData(
          deviceFOs: devicesF0,
          isLess0: true,
        )
      ];
    }

    return [
      SelectableText.rich(
        TextSpan(children: [
          TextSpan(
              text:
                  'Таблица 9.1 - Модель прогнозирования в виде логической таблицы для класса K'),
          TextSpan(text: '1', style: TextStyle(fontSize: 12)),
        ], style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      const SizedBox(
        height: 4,
      ),
      DisplayLogicTableData(
        deviceFOs: devicesF1,
      ),
      const SizedBox(
        height: 24,
      ),
      SelectableText.rich(
        TextSpan(children: [
          TextSpan(
              text:
                  'Таблица 9.2 - Модель прогнозирования в виде логической таблицы для класса K'),
          TextSpan(text: '2', style: TextStyle(fontSize: 12)),
        ], style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      const SizedBox(
        height: 4,
      ),
      DisplayLogicTableData(
        deviceFOs: devicesF0,
        isLess0: true,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    FirstAppProvider provider = context.watch<FirstAppProvider>();
    List<PrivateInfo> infoAboutParams = provider.getPrivateInfoNumber();
    PrivateInfo privateInfo = infoAboutParams[1];
    List<DeviceParams> deviceParams = provider.deviceParams;
    List<FO> privateFOs = provider.getPrivateInfoFOs(privateInfo);
    List<FO> devicesF1 =
        provider.getLogicFOs(fos: privateFOs, paramClass: ParamClass.first);
    List<FO> devicesF0 =
        provider.getLogicFOs(fos: privateFOs, paramClass: ParamClass.second);

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
                          const Text(
                            'Отобразить логические таблицы для класса:',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 4),
                          ToggleButtons(
                            isSelected: [
                              currentResult == 0,
                              currentResult == 1,
                              currentResult == 2,
                            ],
                            borderWidth: 2,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: (int index) {
                              setState(() {
                                currentResult = index;
                              });
                            },
                            children: const [
                              Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'K'),
                                      TextSpan(
                                          text: '1',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              ),
                              Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'K'),
                                      TextSpan(
                                          text: '2',
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              ),
                              Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: ' K'),
                                      TextSpan(
                                          text: '1',
                                          style: TextStyle(fontSize: 12)),
                                      TextSpan(text: 'и K'),
                                      TextSpan(
                                          text: '2',
                                          style: TextStyle(fontSize: 12)),
                                      TextSpan(text: ' '),
                                    ],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(children: [
                            ElevatedButton(
                              onPressed: () {
                                createLogicTablesPdf(
                                    deviceParams: deviceParams,
                                    devicesF0: devicesF0,
                                    devicesF1: devicesF1,
                                    currentResult: currentResult);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(240, 42),
                                backgroundColor: Colors.black,
                              ),
                              child: Text('Экспортировать в pdf'),
                            )
                          ]),
                          const SizedBox(height: 12),
                          ...showResults(context, devicesF1, devicesF0),
                        ]))),
          ],
        ),
      ),
    );
  }
}

class DisplayLogicTableData extends StatefulWidget {
  DisplayLogicTableData({
    super.key,
    required this.deviceFOs,
    this.isLess0 = false,
  });

  List<FO> deviceFOs = [];
  bool isLess0;

  @override
  State<DisplayLogicTableData> createState() => _DisplayLogicTableData();
}

class _DisplayLogicTableData extends State<DisplayLogicTableData> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FixedColumnWidth(240),
          },
          children: [
            TableRow(children: [
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
                      TextSpan(text: 'Сочетание для кодов τ'),
                      TextSpan(text: 'i', style: TextStyle(fontSize: 12))
                    ], style: TextStyle(color: Colors.black, fontSize: 18))),
                  ),
                  Container(
                    height: 31,
                    alignment: Alignment.center,
                    child: Row(children: [
                      ...context
                          .watch<FirstAppProvider>()
                          .deviceParams
                          .map<Expanded>((e) {
                        index++;
                        return Expanded(
                            child: Container(
                                height: 31,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                constraints: BoxConstraints(maxWidth: 240),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: index ==
                                            context
                                                .watch<FirstAppProvider>()
                                                .deviceParams
                                                .length
                                        ? null
                                        : Border(right: BorderSide(width: 1))),
                                child: SelectableText.rich(
                                  TextSpan(
                                      children: [
                                        TextSpan(text: 'код τ'),
                                        TextSpan(
                                            text: index.toString(),
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                )));
                      }).toList(),
                    ]),
                  ),
                ]),
              ),
              Container(
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1),
                        top: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text(
                    'Значение F ${widget.isLess0 ? '<' : '≥'} 0, дв. ед.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
            ]),
            ...widget.deviceFOs
                .map((e) => TableRow(children: [
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1))),
                        child: Row(children: [
                          ...e.params.map<Expanded>((e) {
                            return Expanded(
                                child: Container(
                                    height: 31,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    constraints: BoxConstraints(maxWidth: 240),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1))),
                                    child: Text(e.value,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18))));
                          }).toList(),
                        ]),
                      ),
                      Container(
                        height: 32,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 1),
                                bottom: BorderSide(width: 1))),
                        child: SelectableText.rich(
                          TextSpan(
                              text: e.number,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        ),
                      ),
                    ]))
                .toList()
          ],
        ),
      ],
    );
  }
}
