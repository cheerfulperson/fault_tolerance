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
                                          'Таблица 8 - Частная информация о классах K'),
                                  TextSpan(
                                      text: '1',
                                      style: TextStyle(fontSize: 12)),
                                  TextSpan(text: ', K'),
                                  TextSpan(
                                      text: '2',
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
                        ]))),
          ],
        ),
      ),
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
                TextSpan(text: '2', style: TextStyle(fontSize: 12))
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText.rich(
                        TextSpan(children: [
                          TextSpan(text: 'Частная информация I(T'),
                        ]),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text('(j)', style: TextStyle(fontSize: 12)),
                      SelectableText.rich(
                        TextSpan(children: [
                          TextSpan(text: ' → K'),
                          TextSpan(text: '1', style: TextStyle(fontSize: 12)),
                          TextSpan(text: '), дв. ед.'),
                        ]),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText.rich(
                        TextSpan(children: [
                          TextSpan(text: 'Частная информация I(T'),
                        ]),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text('(j)', style: TextStyle(fontSize: 12)),
                      SelectableText.rich(
                        TextSpan(children: [
                          TextSpan(text: ' → K'),
                          TextSpan(text: '0', style: TextStyle(fontSize: 12)),
                          TextSpan(text: '), дв. ед.'),
                        ]),
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
                        right: BorderSide(width: 1))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(text: 'Прогнозирующая функция F'),
                      ]),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text('(j)', style: TextStyle(fontSize: 12)),
                    SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(text: ', дв. ед.'),
                      ]),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ...getTableRows()
        ]);
  }
}
