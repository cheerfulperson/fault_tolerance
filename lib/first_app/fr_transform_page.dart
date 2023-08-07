import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';
import '../utils/debounce.dart';

class FRTransformPage extends StatefulWidget {
  const FRTransformPage({super.key, required this.title});
  final String title;

  @override
  State<FRTransformPage> createState() => _FRTransformPageState();
}

class _FRTransformPageState extends State<FRTransformPage> {
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
                                                const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Таблица 5 – Результаты преобразования информативных параметров в кодовые сигналы для фрагмента результатов ОЭ, показанного в таблице 2',
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
        DataTableFOs(
            deviceFOs: context.watch<FirstAppProvider>().deviceFOs,
            isSortedFos: context.watch<FirstAppProvider>().isSortedFos),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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

class DataTableFOs extends StatefulWidget {
  DataTableFOs({
    super.key,
    required this.deviceFOs,
    required this.isSortedFos,
  });
  List<FO> deviceFOs = [];
  bool isSortedFos;

  @override
  State<DataTableFOs> createState() => _DataTableFOsState();
}

class _DataTableFOsState extends State<DataTableFOs> {
  int index = 0;
  TableRow getRow(FO data) {
    List<CenteredValue> centeredVales = data.params
        .map((e) =>
            context.watch<FirstAppProvider>().getCenteredValues(e.paramId))
        .toList();

    index++;
    return TableRow(
      children: [
        Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: Text(
              (index).toString(),
              style: TextStyle(fontSize: 20),
            )),
        Container(
          height: 32,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                  right: BorderSide(width: 1))),
          child: ElemParams(
              centeredValues: centeredVales, paramsValue: data.params),
        ),
        Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1), bottom: BorderSide(width: 1))),
          child: Text(
            data.number,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        )
      ],
    );
  }

  List<TableRow> getTableRows() {
    index = 0;
    if (widget.isSortedFos) {
      List<TableRow> k1 = widget.deviceFOs
          .where((element) => element.number == '1')
          .map<TableRow>(getRow)
          .toList();
      index = 0;
      List<TableRow> k0 = widget.deviceFOs
          .where((element) => element.number == '0')
          .map<TableRow>(getRow)
          .toList();
      return [
        TableRow(
          children: [
            Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('')),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1),
              )),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Экземпляры класса K'),
                TextSpan(text: '1', style: TextStyle(fontSize: 12))
              ], style: TextStyle(color: Colors.black, fontSize: 18))),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1),
                      bottom: BorderSide(width: 1))),
              child: Text(''),
            )
          ],
        ),
        ...k1,
        TableRow(
          children: [
            Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('')),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1),
              )),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Экземпляры класса K'),
                TextSpan(text: '0', style: TextStyle(fontSize: 12))
              ], style: TextStyle(color: Colors.black, fontSize: 18))),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1),
                      bottom: BorderSide(width: 1))),
              child: Text(''),
            )
          ],
        ),
        ...k0
      ];
    }
    return widget.deviceFOs.map<TableRow>(getRow).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(160),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(200),
        },
        children: getTableRows());
  }
}

class ElemParams extends StatelessWidget {
  ElemParams({
    super.key,
    required this.paramsValue,
    required this.centeredValues,
  });

  List<DeviceParamValue> paramsValue;
  List<CenteredValue> centeredValues;
  String getParam({String value = '0', required CenteredValue data}) {
    try {
      double k1 = double.parse(data.k1);
      double k0 = double.parse(data.k0);
      double parsedValue = double.parse(value);
      bool isK1Biggger = k0 < k1;
      if (isK1Biggger) {
        if (parsedValue > k1) {
          return '1';
        }
        if (parsedValue < k0) {
          return '0';
        }
        return 'R';
      }
      if (parsedValue > k0) {
        return '1';
      }
      if (parsedValue < k1) {
        return '0';
      }
      return 'R';
    } catch (e) {
      return 'R';
    }
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: paramsValue.map((data) {
      index += 1;
      return Expanded(
          child: Container(
              height: 31,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          width: index == paramsValue.length ? 0 : 1))),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SelectableText(
                getParam(data: centeredValues[index - 1], value: data.value),
                style: TextStyle(fontSize: 18.0),
              )));
    }).toList());
  }
}
