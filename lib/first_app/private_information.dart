import 'package:Method/first_app/components/header.dart';
import 'package:Method/first_app/components/nav_bar.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/display_param.dart';

class PrivateInformationPage extends StatefulWidget {
  const PrivateInformationPage({super.key, required this.title});
  final String title;

  @override
  State<PrivateInformationPage> createState() => _PrivateInformationPageState();
}

class _PrivateInformationPageState extends State<PrivateInformationPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<PrivateInfo> infoAboutParams =
        context.watch<FirstAppProvider>().getPrivateInfoNumber();
    PrivateInfo info = infoAboutParams[0];
    PrivateInfo privateInfo = infoAboutParams[1];
    List<FO> privateFOs =
        context.watch<FirstAppProvider>().getPrivateInfoFOs(privateInfo);

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
                          SelectableText.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Таблица 6 - Значения целочисленных показателей, используемых для расчёта вероятностей (получены анализом таблицы 5)'),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DisplayTableData(
                            info: info,
                            centeredTitle:
                                'Количество экземпляров в ОЭ для ${context.watch<FirstAppProvider>().deviceParams.length}-го кодового сигнала',
                            leftColumnTitle: 'Показатель',
                            marker: 'n',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SelectableText.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Таблица 7 - Значения вероятностей'),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DisplayTableData(
                            info: privateInfo,
                            centeredTitle:
                                'Оценка вероятности для кодового сигнала',
                            leftColumnTitle: 'Вероятность',
                            marker: 'P',
                            isFull: true,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SelectableText.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Таблица 8 - Частная информация о классах K'),
                                  TextSpan(
                                      text: '1',
                                      style: TextStyle(fontSize: 12)),
                                  TextSpan(text: ', K'),
                                  TextSpan(
                                      text: '0',
                                      style: TextStyle(fontSize: 12)),
                                  TextSpan(text: ' и решающая функция'),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DataTableFOs(
                            deviceFOs: privateFOs,
                            isSortedFos:
                                context.watch<FirstAppProvider>().isSortedFos,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SelectableText.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Таблица 9 - Модель прогнозирования в виде логической таблицы для класса K'),
                                  TextSpan(
                                      text: '1',
                                      style: TextStyle(fontSize: 12)),
                                ],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          DisplayLogicTableData(
                            deviceFOs: context
                                .watch<FirstAppProvider>()
                                .getLogicFOs(
                                    fos: privateFOs,
                                    paramClass: ParamClass.first),
                          )
                        ]))),
          ],
        ),
      ),
    );
  }
}

class DisplayTableData extends StatefulWidget {
  DisplayTableData({
    super.key,
    required this.info,
    required this.centeredTitle,
    required this.leftColumnTitle,
    required this.marker,
    this.isFull = false,
  });

  PrivateInfo info;
  String leftColumnTitle;
  String centeredTitle;
  String marker;
  bool isFull;

  @override
  State<DisplayTableData> createState() => _DisplayTableDataState();
}

class _DisplayTableDataState extends State<DisplayTableData> {
  List<TableRow> getRows() {
    if (widget.isFull) {
      int total = context.watch<FirstAppProvider>().deviceCount;
      int k1 = context
          .watch<FirstAppProvider>()
          .deviceFOs
          .where((element) => element.number == '1')
          .length;
      int k0 = context
          .watch<FirstAppProvider>()
          .deviceFOs
          .where((element) => element.number == '0')
          .length;
      String P1 = (k1 / total).toStringAsFixed(3);
      String P0 = (k0 / total).toStringAsFixed(3);

      return [
        TableRow(children: [
          Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: SelectableText.rich(
              TextSpan(children: [
                TextSpan(text: 'P(K'),
                TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                TextSpan(text: ')'),
              ], style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ),
          Container(
            height: 32,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: 31,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      constraints: BoxConstraints(maxWidth: 240),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 1))),
                      child: Text(P1,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18))))
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
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: SelectableText.rich(
              TextSpan(children: [
                TextSpan(text: 'P(K'),
                TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                TextSpan(text: ')'),
              ], style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ),
          Container(
            height: 32,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: 31,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      constraints: BoxConstraints(maxWidth: 240),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 1))),
                      child: Text(P0,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18))))
            ]),
          ),
        ]),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
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
                child: Text(widget.leftColumnTitle,
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
                      TextSpan(text: widget.centeredTitle),
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
                                        TextSpan(text: 'τ'),
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
            ]),
            // -------------------------------- > Row 1
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 1)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK1t1.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 2
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 0)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK1t0.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 3
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = R)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK1tR.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 4
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 1)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK0t1.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 5
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 0)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK0t0.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 6
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker}(K'),
                    TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '|τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = R)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nK0tR.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 7
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker.toLowerCase()}('),
                    TextSpan(text: 'τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 1)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nt1.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 8
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker.toLowerCase()}('),
                    TextSpan(text: 'τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = 0)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.nt0.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            // -------------------------------- > Row 9
            TableRow(children: [
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: '${widget.marker.toLowerCase()}('),
                    TextSpan(text: 'τ'),
                    TextSpan(text: 'i', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' = R)'),
                  ], style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Row(children: [
                  ...widget.info.ntR.map<Expanded>((e) {
                    return Expanded(
                        child: Container(
                            height: 31,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: BoxConstraints(maxWidth: 240),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 1))),
                            child: Text(
                                e.toStringAsFixed(widget.marker == 'n' ? 0 : 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))));
                  }).toList(),
                ]),
              ),
            ]),
            ...getRows(),
          ],
        ),
      ],
    );
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
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                  right: BorderSide(width: 1))),
          child: Text(
            data.params[0].value,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
        Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1), right: BorderSide(width: 1))),
          child: Text(
            data.params[1].value,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
        Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1), right: BorderSide(width: 1))),
          child: Text(
            data.params[2].value,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
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
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
              child: Text(''),
            ),
            Container(
              height: 32,
              alignment: Alignment.centerLeft,
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
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
              child: Text(''),
            ),
            Container(
              height: 32,
              alignment: Alignment.centerLeft,
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
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1),
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1))),
                  child: SelectableText.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Номер экземпляра класса K'),
                      TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                      TextSpan(text: ', j')
                    ]),
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
              Container(
                height: 80,
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1),
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                )),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: 'Частная информация I(T'),
                    TextSpan(text: '(j)', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' → K'),
                    TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '), дв. ед.'),
                  ]),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1),
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                )),
                child: SelectableText.rich(
                  TextSpan(children: [
                    TextSpan(text: 'Частная информация I(T'),
                    TextSpan(text: '(j)', style: TextStyle(fontSize: 12)),
                    TextSpan(text: ' → K'),
                    TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                    TextSpan(text: '), дв. ед.'),
                  ]),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1),
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1),
                        right: BorderSide(width: 1))),
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Прогнозирующая функция F'),
                      TextSpan(text: '(j)', style: TextStyle(fontSize: 12)),
                      TextSpan(text: ', дв. ед.'),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ...getTableRows()
        ]);
  }
}

class DisplayLogicTableData extends StatefulWidget {
  DisplayLogicTableData({
    super.key,
    required this.deviceFOs,
  });

  List<FO> deviceFOs = [];

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
                      TextSpan(text: 'Сочетание τ'),
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
                                        TextSpan(text: 'τ'),
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
                child: Text('Значение F ≥ 0, дв. ед.',
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
