import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';
import '../utils/debounce.dart';

class FRResultsPage extends StatefulWidget {
  const FRResultsPage({super.key, required this.title});
  final String title;

  @override
  State<FRResultsPage> createState() => _FRResultsPageState();
}

class _FRResultsPageState extends State<FRResultsPage> {
  final _debouncer = Debouncer(milliseconds: 1000);

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
                        // Text(
                        //   '1. Объём обучающей выборки был определён в количестве ${context.watch<FirstAppProvider>().deviceCount} экземпляров.',
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   '2. После нумерации экземпляров обучающей выборки у каждого экземпляра были измерены информативные параметры, указанные в таблице 1 - Информативные параметры ППП',
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   '3.Фрагмент результатов ОЭ представлен в таблице 2, в которой экземпляры обучающей выборки сгруппированы отдельно по классам K1 и K0.',
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
                        Text(
                          'Найстройка таблицы',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  _debouncer.run(() {
                                    context
                                        .read<FirstAppProvider>()
                                        .generateDeviceFOs(false);
                                  });
                                  Navigator.pushNamed(
                                      context, firstAppSecondRoute);
                                },
                                child: const Text('Сгенерировать значения')),
                            const SizedBox(
                              width: 12,
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.all(Colors.black),
                              value:
                                  context.watch<FirstAppProvider>().isSortedFos,
                              onChanged: (bool? value) {
                                setState(() {
                                  context
                                      .read<FirstAppProvider>()
                                      .setSortedFos(value ?? false);
                                });
                              },
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        'Cгруппированть отдельно по классам K'),
                                TextSpan(
                                    text: '1', style: TextStyle(fontSize: 12)),
                                TextSpan(text: ' и K'),
                                TextSpan(
                                    text: '0', style: TextStyle(fontSize: 12)),
                              ], style: TextStyle(color: Colors.black)),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Таблица 2 – Фрагмент результатов ОЭ',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const DisplayTableData()
                      ],
                    ))),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(160),
            1: FlexColumnWidth(),
            2: FixedColumnWidth(200),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Номер экземпляра',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('в классе K',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                          const Text('S',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500))
                        ],
                      )
                    ]),
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
                    child: const Text(
                        'Информативный параметр в начальный момент времени',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                  Parameters()
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'Номер класса экземпляра S на момент окончания испытаний',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )),
                    ]),
              ),
            ])
          ],
        ),
        context.watch<FirstAppProvider>().TableFOs,
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        e.shortName,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Consolas',
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        e.shortNameDescription,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Consolas',
                            fontStyle: FontStyle.italic),
                      ),
                      Text(e.unit.isEmpty ? '' : ', ${e.unit}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Consolas',
                              fontStyle: FontStyle.italic))
                    ],
                  )));
        }).toList(),
      ),
    ));
  }
}
