import 'package:Method/first_app/components/header.dart';
import 'package:Method/first_app/components/nav_bar.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProbabilityAssessmentPage extends StatefulWidget {
  const ProbabilityAssessmentPage({super.key, required this.title});
  final String title;

  @override
  State<ProbabilityAssessmentPage> createState() =>
      _ProbabilityAssessmentPageState();
}

class _ProbabilityAssessmentPageState extends State<ProbabilityAssessmentPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<PrivateInfo> infoAboutParams =
        context.watch<FirstAppProvider>().getPrivateInfoNumber();
    PrivateInfo info = infoAboutParams[0];
    PrivateInfo privateInfo = infoAboutParams[1];

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
                                'Количество экземпляров в ОЭ для кодового сигнала',
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
                                        TextSpan(text: 'код τ'),
                                        TextSpan(
                                            text: index.toString(),
                                            style: TextStyle(fontSize: 10)),
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
