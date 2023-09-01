import 'package:flutter/material.dart';

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
}

class FactorString {
  FactorString(
      {required this.fullName, required this.shortName, required this.symbol});

  String fullName;
  String shortName;
  SymbolString symbol;
}

class SecondAppProvider with ChangeNotifier {
  int _trainingSetVolume = 2;
  int _validationSetVolume = 5;
  int _lFactorPoints = 2;
  FactorType _factorType = FactorType.CollectorCurrent;
  String _deviceName = '';
  List<List<String>> _tableData = [];

  int get trainingSetVolume => _trainingSetVolume;
  int get validationSetVolume => _validationSetVolume;
  int get lFactorPoints => _lFactorPoints;
  FactorType get factorType => _factorType;
  String get deviceName => _deviceName;

  void setTrainingSetVolume(int value) {
    _trainingSetVolume = value;
    notifyListeners();
  }

  void setValidationSetVolume(int value) {
    _validationSetVolume = value;
    notifyListeners();
  }

  void setLFactorPoints(int value) {
    _lFactorPoints = value;
    notifyListeners();
  }

  void setDeviceName(String value) {
    _deviceName = value;
    notifyListeners();
  }

  void setFactorType(FactorType value) {
    _factorType = value;
    notifyListeners();
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
