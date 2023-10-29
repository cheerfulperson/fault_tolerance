import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/utils/pdf/make_pdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';

enum ResultType { training, finalResult }

class FirstAppResults extends StatefulWidget {
  const FirstAppResults({super.key, required this.title});
  final String title;

  @override
  State<FirstAppResults> createState() => _FirstAppResultsState();
}

class _FirstAppResultsState extends State<FirstAppResults> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ResultType currentResult = ResultType.training;

  void submitForm(Function cb) {
    if (_formKey.currentState!.validate()) {
      cb();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    late Quality quality;

    if (currentResult == ResultType.finalResult) {
      quality = context.watch<FirstAppProvider>().getFinalQuality();
    } else {
      quality = context.watch<FirstAppProvider>().getQuality();
    }

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirstAppNavBar(),
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
                        Text(
                          'Сделать расчет для выборки:',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 4),
                        ToggleButtons(
                          isSelected: [
                            currentResult == ResultType.training,
                            currentResult == ResultType.finalResult,
                          ],
                          borderWidth: 2,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: (int index) {
                            setState(() {
                              if (index == 0) {
                                currentResult = ResultType.training;
                              } else {
                                currentResult = ResultType.finalResult;
                              }
                            });
                          },
                          children: [
                            Text(
                              ' Обучающая выборка ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              ' Контрольная выборка ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(children: [
                          ElevatedButton(
                            onPressed: () {
                              createResultTablesPdf(quality: quality);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(240, 42),
                              backgroundColor: Colors.black,
                            ),
                            child: Text('Экспортировать в pdf'),
                          )
                        ]),
                        const SizedBox(height: 16),
                        Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.top,
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FixedColumnWidth(200),
                            },
                            children: [
                              TableRow(children: [
                                Container(
                                  height: 56,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(width: 1),
                                          right: BorderSide(width: 1),
                                          top: BorderSide(width: 1))),
                                  child: SelectableText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: 'Информация'),
                                      ],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  height: 56,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(width: 1),
                                          top: BorderSide(width: 1))),
                                  child: SelectableText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: 'Результат'),
                                      ],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Container(
                                  height: 72,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(width: 1),
                                          right: BorderSide(width: 1),
                                          top: BorderSide(width: 1))),
                                  child: SelectableText.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                                          TextSpan(
                                              text: '1',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                ),
                                Container(
                                  height: 72,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(width: 1),
                                          top: BorderSide(width: 1))),
                                  child: SelectableText.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: '   n'),
                                          TextSpan(
                                              text: '1→1',
                                              style: TextStyle(fontSize: 12)),
                                          TextSpan(text: ' = ${quality.n11}'),
                                        ],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )
                              ]),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                                            TextSpan(
                                                text: '2',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   n'),
                                            TextSpan(
                                                text: '0→0',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: ' = ${quality.n00}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Вероятность принятия правильных решений по прогнозу P'),
                                            TextSpan(
                                                text: 'прав',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' для всей обучающей выборки'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'прав',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.Pprav.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Вероятность принятия по прогнозу ошибочных решений P'),
                                            TextSpan(
                                                text: 'ош',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' для всей обучающей выборки'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'ош',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.Poh.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Вероятность правильного прогноза экземпляров класса K'),
                                            TextSpan(
                                                text: '1',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'прав',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: '(K'),
                                            TextSpan(
                                                text: '1',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: ')'),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.PpravK1.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Вероятность правильного прогноза экземпляров класса K'),
                                            TextSpan(
                                                text: '2',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'прав',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: '(K'),
                                            TextSpan(
                                                text: '2',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(text: ')'),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.PpravK0.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Риск потребителя P'),
                                            TextSpan(
                                                text: 'потреб',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'потреб',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.Ppotreb.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(width: 1),
                                            bottom: BorderSide(width: 1),
                                            right: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Риск изготовителя P'),
                                            TextSpan(
                                                text: 'изгот',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Container(
                                    height: 72,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(width: 1),
                                            bottom: BorderSide(width: 1),
                                            top: BorderSide(width: 1))),
                                    child: SelectableText.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: '   P'),
                                            TextSpan(
                                                text: 'изгот',
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text:
                                                    ' = ${quality.Pizgot.toStringAsFixed(3)}'),
                                          ],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ]),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
