import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:Method/providers/first_app_provider.dart';

class AppStorage {
  AppStorage({required this.fileName});
  String fileName;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<FirstAppState> readFirstAppProviderData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return FirstAppState();
    }
  }

  Future<File> wrightFirstAppProviderData(FirstAppState state) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(jsonEncode(state));
  }
}
