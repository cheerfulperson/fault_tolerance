import 'package:Method/providers/store.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'dart:math';

// Переключатель
enum FactorType {
  CollectorCurrent,
  Temperature,
  CollectorEmitterVoltage,
}

class SymbolString {
  SymbolString({required this.fullName, required this.shortName});

  String fullName;
  String shortName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['shortName'] = this.shortName;

    return data;
  }
}

class FactorString {
  FactorString(
      {required this.fullName, required this.shortName, required this.symbol});

  String fullName;
  String shortName;
  SymbolString symbol;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['shortName'] = this.shortName;
    data['symbol'] = this.symbol.toJson();

    return data;
  }
}

class Forecast {
  Forecast({required this.Ppr, required this.Pis});

  double? Ppr;
  double? Pis;
}

class SecondAppProvider with ChangeNotifier {
  SecondAppProvider() {
    pushToHistory();
  }

  int _trainingSetVolume = 2;
  int _validationSetVolume = 5;
  int _lFactorPoints = 2;
  int _selectedTime = 0;
  FactorType _factorType = FactorType.CollectorCurrent;
  String _deviceName = '';
  List<List<double?>> _tableData = List.generate(
      7, (_) => List<double?>.filled(2, null, growable: true),
      growable: true);
  List<List<double?>> _timeTableData = List.generate(
      7, (_) => List<double?>.filled(2, null, growable: true),
      growable: true);
  List<double?> _tableParams = List<double?>.filled(2, null, growable: true);
  List<String?> _listFormulaParams =
      List.generate(7, (_) => '', growable: true);
  String _secondFormula = '';
  String _thirdFormula = '';
  String _fourthFormula = '';
  double _workTime = 0;
  double? _appResults = 0;
  List<Map<String, dynamic>> _history = List.empty(growable: true);

  FactorType get factorType => _factorType;
  List<List<double?>> get tableData => _tableData;
  List<List<double?>> get timeTableData => _timeTableData;
  List<String?> get listFormulaParams => _listFormulaParams;
  List<double?> get tableParams => _tableParams;
  String get deviceName => _deviceName;
  String get secondFormula => _secondFormula;
  String get thirdFormula => _thirdFormula;
  String get fourthFormula => _fourthFormula;
  int get lFactorPoints => _lFactorPoints;
  int get trainingSetVolume => _trainingSetVolume;
  int get validationSetVolume => _validationSetVolume;
  int get selectedTime => _selectedTime;
  double get workTime => _workTime;
  double? get appResults => _appResults;

  final AppStorage _store = AppStorage();

  void setTrainingSetVolume(int value) {
    if (_trainingSetVolume >= value) {
      _tableData.removeRange(value, _trainingSetVolume);
      _timeTableData.removeRange(value, _trainingSetVolume);
      _listFormulaParams.removeRange(value, _trainingSetVolume);
    } else {
      List<List<double?>> data = List.generate(
        value - _trainingSetVolume,
        (_) => List<double?>.filled(_lFactorPoints, null),
      );
      List<String?> strData = List.generate(
        value - _trainingSetVolume,
        (_) => '',
      );
      _listFormulaParams.insertAll(_trainingSetVolume, strData);
      _tableData.insertAll(_trainingSetVolume, data);
      _timeTableData.insertAll(_trainingSetVolume, data);
    }
    _trainingSetVolume = value;
    pushToHistory();
    notifyListeners();
  }

  void setValidationSetVolume(int value) {
    if (_validationSetVolume >= value) {
      _tableData.removeRange(value + _trainingSetVolume,
          _validationSetVolume + _trainingSetVolume);
      _timeTableData.removeRange(value + _trainingSetVolume,
          _validationSetVolume + _trainingSetVolume);
      _listFormulaParams.removeRange(value + _trainingSetVolume,
          _validationSetVolume + _trainingSetVolume);
    } else {
      List<List<double?>> data = List.generate(
        value - _validationSetVolume,
        (_) => List<double?>.filled(_lFactorPoints, null),
      );
      List<String?> strData = List.generate(
        value - _trainingSetVolume,
        (_) => '',
      );
      _listFormulaParams.insertAll(_trainingSetVolume, strData);
      _tableData.addAll(data);
      _timeTableData.addAll(data);
    }
    _validationSetVolume = value;
    pushToHistory();
    notifyListeners();
  }

  void setLFactorPoints(int value) {
    _tableData = _tableData.map((e) {
      if (_lFactorPoints >= value) {
        e.removeRange(value, _lFactorPoints);
      } else {
        List<double?> data = List.generate(
          value - _lFactorPoints,
          (_) => null,
          growable: true,
        );
        e.addAll(data);
      }
      return e;
    }).toList();
    _timeTableData = _timeTableData.map((e) {
      if (_lFactorPoints >= value) {
        e.removeRange(value, _lFactorPoints);
      } else {
        List<double?> data = List.generate(
          value - _lFactorPoints,
          (_) => null,
          growable: true,
        );
        e.addAll(data);
      }
      return e;
    }).toList();
    if (_lFactorPoints >= value) {
      _tableParams.removeRange(value, _lFactorPoints);
    } else {
      List<double?> data = List.generate(
        value - _lFactorPoints,
        (_) => null,
        growable: true,
      );

      _tableParams.addAll(data);
    }
    _lFactorPoints = value;
    pushToHistory();
    notifyListeners();
  }

  void setDeviceName(String value) {
    _deviceName = value;
    pushToHistory();
    notifyListeners();
  }

  void setSecondFormula(String value) {
    _secondFormula = value;
    pushToHistory();
    notifyListeners();
  }

  void setThirdFormula(String value) {
    _thirdFormula = value;
    pushToHistory();
    notifyListeners();
  }

  void setFourthFormula(String value) {
    _fourthFormula = value;
    _appResults = calculateByF5(_workTime);
    pushToHistory();
    notifyListeners();
  }

  void setFactorType(FactorType value) {
    _factorType = value;
    pushToHistory();
    notifyListeners();
  }

  void setWorkTime(double time) {
    _workTime = time;
    _appResults = calculateByF5(time);
    pushToHistory();
    notifyListeners();
  }

  void setSelectedTime(int value) {
    _selectedTime = value;
    pushToHistory();
    notifyListeners();
  }

  void pushToHistory() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = _deviceName;
    data['factorType'] = _factorType.index;
    data['fourthFormula'] = _fourthFormula;
    data['lFactorPoints'] = _lFactorPoints;
    data['listFormulaParams'] = List.from(_listFormulaParams);
    data['secondFormula'] = _secondFormula;
    data['selectedTime'] = _selectedTime;
    data['tableData'] = List.from(_tableData.map((e) => List.from(e)).toList());
    data['tableParams'] = List.from(_tableParams);
    data['thirdFormula'] = _thirdFormula;
    data['timeTableData'] =
        List.from(_timeTableData.map((e) => List.from(e)).toList());
    data['trainingSetVolume'] = _trainingSetVolume;
    data['validationSetVolume'] = _validationSetVolume;
    data['workTime'] = _workTime;
    _history.add(data);
  }

  void undoLast() {
    try {
      if (_history.length < 2) {
        return;
      }

      Map<String, dynamic> data = _history[_history.length - 2];
      if (data == null) {
        return;
      }
      _deviceName = data['deviceName'];
      _factorType = [
        FactorType.CollectorCurrent,
        FactorType.Temperature,
        FactorType.CollectorEmitterVoltage,
      ][data['factorType']];
      _fourthFormula = data['fourthFormula'];
      _lFactorPoints = data['lFactorPoints'];
      List<String?> listFormulaParams =
          List<String?>.from(data['listFormulaParams'], growable: true);
      _listFormulaParams = [];
      for (int i = 0; i < listFormulaParams.length; i++) {
        _listFormulaParams.add(listFormulaParams[i]);
      }
      _secondFormula = data['secondFormula'];
      _selectedTime = data['selectedTime'];

      List<dynamic> tableData = data['tableData'];
      _tableData = [];
      for (int i = 0; i < tableData.length; i++) {
        List<double?> data = [];
        for (int j = 0; j < tableData[i].length; j++) {
          double? num = tableData[i][j];
          data.add(num);
        }
        _tableData.add(data);
      }

      List<dynamic> tableParams = data['tableParams'];
      _tableParams = [];
      for (int i = 0; i < tableParams.length; i++) {
        _tableParams.add(tableParams[i]);
      }

      _thirdFormula = data['thirdFormula'];
      List<dynamic> timeTableData = data['timeTableData'];
      _timeTableData = [];
      for (int i = 0; i < timeTableData.length; i++) {
        List<double?> data = [];
        for (int j = 0; j < timeTableData[i].length; j++) {
          double? num = timeTableData[i][j];
          data.add(num);
        }
        _timeTableData.add(data);
      }

      _trainingSetVolume = data['trainingSetVolume'];
      _validationSetVolume = data['validationSetVolume'];
      _workTime = data['workTime'];
      _history.removeLast();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> saveToFile({bool isNeedNewPath = false}) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = _deviceName;
    data['factorType'] = _factorType.index;
    data['fourthFormula'] = _fourthFormula;
    data['lFactorPoints'] = _lFactorPoints;
    data['listFormulaParams'] = _listFormulaParams;
    data['secondFormula'] = _secondFormula;
    data['selectedTime'] = _selectedTime;
    data['tableData'] = _tableData;
    data['tableParams'] = _tableParams;
    data['thirdFormula'] = _thirdFormula;
    data['timeTableData'] = _timeTableData;
    data['trainingSetVolume'] = _trainingSetVolume;
    data['validationSetVolume'] = _validationSetVolume;
    data['workTime'] = _workTime;

    await _store.saveToFile(
        data: data, isNeedNewPath: isNeedNewPath, suffix: 'mif');
    notifyListeners();
  }

  Future<void> importData() async {
    try {
      Map<String, dynamic>? data = await _store.getDataFromFile();
      if (data == null) {
        return;
      }

      _deviceName = data['deviceName'];
      _factorType = [
        FactorType.CollectorCurrent,
        FactorType.Temperature,
        FactorType.CollectorEmitterVoltage,
      ][data['factorType']];
      _fourthFormula = data['fourthFormula'];
      _lFactorPoints = data['lFactorPoints'];
      List<String?> listFormulaParams =
          List<String?>.from(data['listFormulaParams'], growable: true);
      _listFormulaParams = [];
      for (int i = 0; i < listFormulaParams.length; i++) {
        _listFormulaParams.add(listFormulaParams[i]);
      }
      _secondFormula = data['secondFormula'];
      _selectedTime = data['selectedTime'];

      List<dynamic> tableData = data['tableData'];
      _tableData = [];
      for (int i = 0; i < tableData.length; i++) {
        List<double?> data = [];
        for (int j = 0; j < tableData[i].length; j++) {
          double? num = tableData[i][j];
          data.add(num);
        }
        _tableData.add(data);
      }

      List<dynamic> tableParams = data['tableParams'];
      _tableParams = [];
      for (int i = 0; i < tableParams.length; i++) {
        _tableParams.add(tableParams[i]);
      }

      _thirdFormula = data['thirdFormula'];
      List<dynamic> timeTableData = data['timeTableData'];
      _timeTableData = [];
      for (int i = 0; i < timeTableData.length; i++) {
        List<double?> data = [];
        for (int j = 0; j < timeTableData[i].length; j++) {
          double? num = timeTableData[i][j];
          data.add(num);
        }
        _timeTableData.add(data);
      }

      _trainingSetVolume = data['trainingSetVolume'];
      _validationSetVolume = data['validationSetVolume'];
      _workTime = data['workTime'];
      notifyListeners();
    } catch (e) {}
  }

  double? calculateByF5(double value) {
    try {
      final f5 = fourthFormula.toSingleVariableFunction();
      return f5(value).toDouble();
    } catch (e) {
      return null;
    }
  }

  List<Forecast> getForecast() {
    double? timeAverage = null;
    try {
      final f5 = fourthFormula.toSingleVariableFunction();
      List<double> average = getTimeAverage();
      timeAverage = f5(average[_selectedTime]).toDouble();
    } catch (e) {
      timeAverage = null;
    }
    if (timeAverage == null) {
      return List.generate(
          _validationSetVolume,
          (index) =>
              Forecast(Pis: _timeTableData[index][selectedTime], Ppr: null));
    }
    int index = _trainingSetVolume - 1;
    return _listFormulaParams.sublist(_trainingSetVolume).map((e) {
      index++;
      if (e == null) {
        return Forecast(Pis: _timeTableData[index][selectedTime], Ppr: null);
      }
      try {
        double data = e.toSingleVariableFunction()(timeAverage ?? 0).toDouble();
        return Forecast(Pis: _timeTableData[index][selectedTime], Ppr: data);
      } catch (e) {
        return Forecast(Pis: _timeTableData[index][selectedTime], Ppr: null);
      }
    }).toList();
  }

  List<double> getAverage() {
    List<double> averages =
        List<double>.filled(_lFactorPoints, 0, growable: true);
    for (int index = 0; index < lFactorPoints; index++) {
      double average = 0;
      for (int jndex = 0;
          jndex < _trainingSetVolume + _validationSetVolume;
          jndex++) {
        if (_tableData[jndex][index] != null) {
          average += _tableData[jndex][index] ?? 0;
        }
      }
      averages[index] = average;
    }
    return averages;
  }

  List<double> getTimeAverage() {
    List<double> averages =
        List<double>.filled(_lFactorPoints, 0, growable: true);
    for (int index = 0; index < lFactorPoints; index++) {
      double average = 0;
      for (int jndex = 0;
          jndex < _trainingSetVolume + _validationSetVolume;
          jndex++) {
        if (_timeTableData[jndex][index] != null) {
          average += _timeTableData[jndex][index] ?? 0;
        }
      }
      averages[index] = average;
    }
    return averages;
  }

  double getDepsAverage(List<Forecast> list) {
    double average = 0;
    list.forEach((element) {
      if (element.Pis != null && element.Ppr != null) {
        average += pow(
            (((element.Ppr ?? 0) - (element.Pis ?? 0)) / (element.Pis ?? 1)),
            2);
      }
    });
    return pow(average / list.length, 0.5).toDouble();
  }

  FactorString getFactorNames() {
    String fullName = 'Тока коллектора';
    String shortName = 'Тока';
    SymbolString symbol = SymbolString(fullName: 'I', shortName: 'k');

    switch (_factorType) {
      case FactorType.Temperature:
        fullName = 'Температуры';
        shortName = 'Температуры';
        symbol = SymbolString(fullName: 'T', shortName: '');
        break;
      case FactorType.CollectorEmitterVoltage:
        fullName = 'Напряжения коллектор-эммитер';
        shortName = 'Напряжения';
        symbol = SymbolString(fullName: 'U', shortName: 'кэ');
        break;
      default:
        break;
    }
    return FactorString(
        fullName: fullName, shortName: shortName, symbol: symbol);
  }
}
