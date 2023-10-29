import 'dart:io';

import 'package:Method/providers/first_app_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget displayResultsTable(
    {required Quality quality, required pw.Font robotoRegularFont}) {
  return pw.Table(
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
      columnWidths: const <int, pw.TableColumnWidth>{
        0: pw.FlexColumnWidth(),
        1: pw.FixedColumnWidth(200),
      },
      children: [
        pw.TableRow(children: [
          pw.Container(
            height: 56,
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    left: pw.BorderSide(width: 1),
                    right: pw.BorderSide(width: 1),
                    top: pw.BorderSide(width: 1))),
            child: pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(text: 'Информация'),
                ],
                style: pw.TextStyle(
                    font: robotoRegularFont,
                    color: PdfColor.fromHex('#4a4a4a'),
                    fontFallback: [robotoRegularFont]),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            height: 56,
            alignment: pw.Alignment.center,
            padding: pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    right: pw.BorderSide(width: 1),
                    top: pw.BorderSide(width: 1))),
            child: pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(text: 'Результат'),
                ],
                style: pw.TextStyle(
                    font: robotoRegularFont,
                    color: PdfColor.fromHex('#4a4a4a'),
                    fontFallback: [robotoRegularFont]),
              ),
              textAlign: pw.TextAlign.center,
            ),
          )
        ]),
        pw.TableRow(children: [
          pw.Container(
            height: 72,
            alignment: pw.Alignment.centerLeft,
            padding: pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    left: pw.BorderSide(width: 1),
                    right: pw.BorderSide(width: 1),
                    top: pw.BorderSide(width: 1))),
            child: pw.RichText(
              text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                        text:
                            'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                    pw.TextSpan(text: '1', style: pw.TextStyle(fontSize: 8)),
                  ],
                  style: pw.TextStyle(
                      font: robotoRegularFont,
                      color: PdfColor.fromHex('#4a4a4a'),
                      fontFallback: [robotoRegularFont])),
            ),
          ),
          pw.Container(
            height: 72,
            alignment: pw.Alignment.centerLeft,
            padding: pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    right: pw.BorderSide(width: 1),
                    top: pw.BorderSide(width: 1))),
            child: pw.RichText(
              text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: '   n'),
                    pw.TextSpan(text: '1->1', style: pw.TextStyle(fontSize: 8)),
                    pw.TextSpan(text: ' = ${quality.n11}'),
                  ],
                  style: pw.TextStyle(
                      font: robotoRegularFont,
                      color: PdfColor.fromHex('#4a4a4a'),
                      fontFallback: [robotoRegularFont])),
            ),
          )
        ]),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text:
                              'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                      pw.TextSpan(text: '2', style: pw.TextStyle(fontSize: 8)),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   n'),
                      pw.TextSpan(
                          text: '0->0', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ' = ${quality.n00}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text:
                              'Вероятность принятия правильных решений по прогнозу P'),
                      pw.TextSpan(
                          text: 'прав', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ' для всей обучающей выборки'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(
                          text: 'прав', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(
                          text: ' = ${quality.Pprav.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text:
                              'Вероятность принятия по прогнозу ошибочных решений P'),
                      pw.TextSpan(text: 'ош', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ' для всей обучающей выборки'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(text: 'ош', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ' = ${quality.Poh.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text:
                              'Вероятность правильного прогноза экземпляров класса K'),
                      pw.TextSpan(text: '1', style: pw.TextStyle(fontSize: 8)),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(
                          text: 'прав', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: '(K'),
                      pw.TextSpan(text: '1', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ')'),
                      pw.TextSpan(
                          text: ' = ${quality.PpravK1.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text:
                              'Вероятность правильного прогноза экземпляров класса K'),
                      pw.TextSpan(text: '2', style: pw.TextStyle(fontSize: 8)),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(
                          text: 'прав', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: '(K'),
                      pw.TextSpan(text: '2', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(text: ')'),
                      pw.TextSpan(
                          text: ' = ${quality.PpravK0.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: 'Риск потребителя P'),
                      pw.TextSpan(
                          text: 'потреб', style: pw.TextStyle(fontSize: 8)),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(
                          text: 'потреб', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(
                          text: ' = ${quality.Ppotreb.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1),
                      bottom: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: 'Риск изготовителя P'),
                      pw.TextSpan(
                          text: 'изгот', style: pw.TextStyle(fontSize: 8)),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            ),
            pw.Container(
              height: 72,
              alignment: pw.Alignment.centerLeft,
              padding: pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      bottom: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1))),
              child: pw.RichText(
                text: pw.TextSpan(
                    children: [
                      pw.TextSpan(text: '   P'),
                      pw.TextSpan(
                          text: 'изгот', style: pw.TextStyle(fontSize: 8)),
                      pw.TextSpan(
                          text: ' = ${quality.Pizgot.toStringAsFixed(3)}'),
                    ],
                    style: pw.TextStyle(
                        font: robotoRegularFont,
                        color: PdfColor.fromHex('#4a4a4a'),
                        fontFallback: [robotoRegularFont])),
              ),
            )
          ],
        ),
      ]);
}
