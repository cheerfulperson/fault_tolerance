import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/utils/pdf/display_logic_table_pdf.dart';
import 'package:Method/utils/pdf/display_results_table_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void createLogicTablesPdf(
    {required List<DeviceParams> deviceParams,
    required List<FO> devicesF1,
    required List<FO> devicesF0,
    required int currentResult}) async {
  final pdf = pw.Document();
  Directory current = Directory.current;
  late Uint8List fontData;
  try {
    fontData = await File(
            '${current.path}/data/flutter_assets/assets/fonts/Roboto-Regular.ttf')
        .readAsBytes();
  } catch (e) {
    fontData = await File('assets/fonts/Roboto-Regular.ttf').readAsBytes();
  }
  final robotoRegularFont = pw.Font.ttf(fontData.buffer.asByteData());

  List<pw.Widget> displayInfo() {
    if (currentResult == 0) {
      return [
        pw.RichText(
          text: pw.TextSpan(
              children: [
                pw.TextSpan(
                    text:
                        'Таблица 1 - Модель прогнозирования в виде логической таблицы для класса K'),
                pw.TextSpan(
                    text: '1',
                    style: pw.TextStyle(
                      fontSize: 8,
                      font: robotoRegularFont,
                    )),
              ],
              style: pw.TextStyle(
                  color: PdfColor.fromHex('#4a4a4a'), font: robotoRegularFont)),
        ),
        pw.SizedBox(
          height: 4,
        ),
        createLogicTablePdf(
            deviceParams: deviceParams,
            deviceFOs: devicesF1,
            robotoRegularFont: robotoRegularFont)
      ];
    }

    if (currentResult == 1) {
      return [
        pw.RichText(
          text: pw.TextSpan(
              children: [
                pw.TextSpan(
                    text:
                        'Таблица 1 - Модель прогнозирования в виде логической таблицы для класса K'),
                pw.TextSpan(
                    text: '2',
                    style: pw.TextStyle(
                      fontSize: 8,
                      font: robotoRegularFont,
                    )),
              ],
              style: pw.TextStyle(
                  color: PdfColor.fromHex('#4a4a4a'), font: robotoRegularFont)),
        ),
        pw.SizedBox(
          height: 4,
        ),
        createLogicTablePdf(
            deviceParams: deviceParams,
            deviceFOs: devicesF0,
            robotoRegularFont: robotoRegularFont,
            isLess0: true)
      ];
    }
    return [
      pw.RichText(
        text: pw.TextSpan(
            children: [
              pw.TextSpan(
                  text:
                      'Таблица 1 - Модель прогнозирования в виде логической таблицы для класса K'),
              pw.TextSpan(
                  text: '1',
                  style: pw.TextStyle(
                    fontSize: 8,
                    font: robotoRegularFont,
                  )),
            ],
            style: pw.TextStyle(
                color: PdfColor.fromHex('#4a4a4a'), font: robotoRegularFont)),
      ),
      pw.SizedBox(
        height: 4,
      ),
      createLogicTablePdf(
          deviceParams: deviceParams,
          deviceFOs: devicesF1,
          robotoRegularFont: robotoRegularFont),
      pw.SizedBox(
        height: 24,
      ),
      pw.RichText(
        text: pw.TextSpan(
            children: [
              pw.TextSpan(
                  text:
                      'Таблица 2 - Модель прогнозирования в виде логической таблицы для класса K'),
              pw.TextSpan(
                  text: '2',
                  style: pw.TextStyle(
                    fontSize: 8,
                    font: robotoRegularFont,
                  )),
            ],
            style: pw.TextStyle(
                color: PdfColor.fromHex('#4a4a4a'), font: robotoRegularFont)),
      ),
      pw.SizedBox(
        height: 4,
      ),
      createLogicTablePdf(
          deviceParams: deviceParams,
          deviceFOs: devicesF0,
          robotoRegularFont: robotoRegularFont,
          isLess0: true)
    ];
  }

  pdf.addPage(
    pw.MultiPage(
      maxPages: 150,
      build: (pw.Context context) => [
        pw.Column(
          children: [...displayInfo()],
        )
      ],
    ),
  );

  String? __filePath = await FilePicker.platform.saveFile(
    dialogTitle: 'Выберите путь куда сохранить файл',
    allowedExtensions: ['pdf'],
    type: FileType.custom,
  );

  final file = File('${__filePath?.replaceAll('.pdf', '')}.pdf');
  await file.writeAsBytes(await pdf.save());
}

void createResultTablesPdf({required Quality quality}) async {
  try {
    final pdf = pw.Document();
    Directory current = Directory.current;
    final Uint8List fontData = await File(
            '${current.path}/data/flutter_assets/assets/fonts/Roboto-Regular.ttf')
        .readAsBytes();
    final robotoRegularFont = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            displayResultsTable(
                quality: quality, robotoRegularFont: robotoRegularFont)
          ],
        ),
      ),
    );

    String? __filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Выберите путь куда сохранить файл',
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    final file = File('${__filePath?.replaceAll('.pdf', '')}.pdf');
    await file.writeAsBytes(await pdf.save());
  } catch (e) {
    Directory current = Directory.current;
    final file = File('logs.txt');
    await file.writeAsString(e.toString() + '\n' + current.path);
  }
}
