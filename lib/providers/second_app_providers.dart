import 'package:flutter/material.dart';

class SecondAppProvider with ChangeNotifier {
  String _trainingSetVolume = '';
  String _validationSetVolume = '';
  String _lFactorPoints = '';

  String get trainingSetVolume => _trainingSetVolume;
  String get validationSetVolume => _validationSetVolume;
  String get lFactorPoints => _lFactorPoints;

  void setTrainingSetVolume(String value) {
    _trainingSetVolume = value;
    notifyListeners();
  }

  void setValidationSetVolume(String value) {
    _validationSetVolume = value;
    notifyListeners();
  }

  void setLFactorPoints(String value) {
    _lFactorPoints = value;
    notifyListeners();
  }
}
