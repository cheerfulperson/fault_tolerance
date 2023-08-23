import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class AppStorage {
  AppStorage();

  late String? _fileName;

  @override
  String? get fileName => _fileName;

  Future<void> saveToFile(
      {required bool isNeedNewPath, required Map<String, dynamic> data}) async {
    String? filePath = _fileName;
    if (isNeedNewPath || filePath == null || filePath.isEmpty) {
      filePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Выберите путь куда сохранить файл',
        allowedExtensions: ['json'],
        type: FileType.custom,
      );
    }

    if (filePath == null || filePath.isEmpty) {
      return;
    }
    _fileName = filePath;
    final File file = File('$filePath.json');
    await file.writeAsString(json.encode(data));
  }

  Future<Map<String, dynamic>?> getDataFromFile() async {
    try {
      FilePickerResult? fileInfo = await FilePicker.platform.pickFiles(
        allowedExtensions: ['json'],
        type: FileType.custom,
        allowMultiple: false,
      );

      if (fileInfo == null) {
        return null;
      }

      _fileName = fileInfo.paths[0];
      final File file = File(_fileName ?? '');
      Map<String, dynamic> data = json.decode(await file.readAsString());
      return data;
    } catch (e) {
      return null;
    }
  }
}
