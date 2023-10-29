import 'dart:io';

import 'package:Method/providers/first_app_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget createLogicTablePdf(
    {required List<FO> deviceFOs,
    required List<DeviceParams> deviceParams,
    required pw.Font robotoRegularFont,
    bool isLess0 = false}) {
  int index = 0;

  return pw.Column(
    children: [
      pw.Table(
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.top,
        columnWidths: const <int, pw.TableColumnWidth>{
          0: pw.FlexColumnWidth(),
          1: pw.FixedColumnWidth(80),
        },
        children: [
          pw.TableRow(children: [
            pw.Container(
              height: 64,
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                width: 1,
              )),
              child: pw.Column(children: [
                pw.Container(
                  height: 31,
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.symmetric(horizontal: 8),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: 1))),
                  child: pw.RichText(
                      text: pw.TextSpan(
                          children: [
                        pw.TextSpan(text: 'Сочетание для кодов τ'),
                        pw.TextSpan(
                            text: 'i',
                            style: pw.TextStyle(
                                fontSize: 10, font: robotoRegularFont))
                      ],
                          style: pw.TextStyle(
                              color: PdfColor.fromHex('#4a4a4a'),
                              font: robotoRegularFont))),
                ),
                pw.Container(
                  height: 31,
                  alignment: pw.Alignment.center,
                  child: pw.Row(children: [
                    ...deviceParams.map<pw.Expanded>((e) {
                      index++;
                      return pw.Expanded(
                          child: pw.Container(
                              height: 31,
                              padding: pw.EdgeInsets.symmetric(horizontal: 8),
                              constraints: pw.BoxConstraints(maxWidth: 240),
                              alignment: pw.Alignment.center,
                              decoration: pw.BoxDecoration(
                                  border: index == deviceParams.length
                                      ? null
                                      : pw.Border(
                                          right: pw.BorderSide(width: 1))),
                              child: pw.RichText(
                                text: pw.TextSpan(
                                    children: [
                                      pw.TextSpan(text: 'код τ'),
                                      pw.TextSpan(
                                          text: index.toString(),
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                            font: robotoRegularFont,
                                          )),
                                    ],
                                    style: pw.TextStyle(
                                        color: PdfColor.fromHex('#4a4a4a'),
                                        font: robotoRegularFont)),
                              )));
                    }).toList(),
                  ]),
                ),
              ]),
            ),
            pw.Container(
              height: 64,
              padding: pw.EdgeInsets.symmetric(horizontal: 8),
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      right: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1),
                      bottom: pw.BorderSide(width: 1))),
              child: pw.RichText(
                  textAlign: pw.TextAlign.center,
                  text: pw.TextSpan(
                      children: [
                        pw.TextSpan(
                            text:
                                'Значение \nF ${isLess0 ? '<' : '>='} 0,\n дв. ед.',
                            style: pw.TextStyle(font: robotoRegularFont)),
                      ],
                      style: pw.TextStyle(
                          color: PdfColor.fromHex('#4a4a4a'),
                          fontFallback: [robotoRegularFont]))),
            ),
          ]),
          ...deviceFOs
              .map((e) => pw.TableRow(children: [
                    pw.Container(
                      height: 32,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              left: pw.BorderSide(width: 1),
                              bottom: pw.BorderSide(width: 1))),
                      child: pw.Row(children: [
                        ...e.params.map<pw.Expanded>((e) {
                          return pw.Expanded(
                              child: pw.Container(
                                  height: 31,
                                  padding:
                                      pw.EdgeInsets.symmetric(horizontal: 8),
                                  constraints: pw.BoxConstraints(maxWidth: 240),
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          right: pw.BorderSide(width: 1))),
                                  child: pw.Text(e.value,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                          color: PdfColor.fromHex('#4a4a4a'),
                                          font: robotoRegularFont))));
                        }).toList(),
                      ]),
                    ),
                    pw.Container(
                      height: 32,
                      padding: pw.EdgeInsets.symmetric(horizontal: 8),
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                          border: pw.Border(
                              right: pw.BorderSide(width: 1),
                              bottom: pw.BorderSide(width: 1))),
                      child: pw.Text(e.number,
                          style: pw.TextStyle(
                              color: PdfColor.fromHex('#4a4a4a'),
                              font: robotoRegularFont)),
                    ),
                  ]))
              .toList()
        ],
      ),
    ],
  );
}
