import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:Method/providers/store.dart';

const Uuid uuid = Uuid();

class DeviceParams {
  DeviceParams(
      {required this.name,
      required this.shortName,
      this.shortNameDescription = '',
      this.number = 0,
      required this.unit});
  String id = uuid.v4();
  int number;
  String name;
  String shortName;
  String shortNameDescription;
  String unit;
}

class FirstAppState {
  int get deviceCount => 10;
  String get deviceName => '';
  List<DeviceParams> get deviceParams => [];
}

class FirstAppProvider with ChangeNotifier implements FirstAppState {
  FirstAppProvider() {
    _init();
  }

  final AppStorage _appStore = AppStorage(fileName: 'first_app.json');
  final List<DeviceParams> _deviceParams = [];
  String _deviceName = '';
  int _deviceCount = 10;

  @override
  int get deviceCount => _deviceCount;
  @override
  String get deviceName => _deviceName;
  @override
  List<DeviceParams> get deviceParams => _deviceParams;

  void setDeviceName(String name) {
    _deviceName = name;
    notifyListeners();
  }

  void setDevicesCount(int count) {
    _deviceCount = count;
    notifyListeners();
  }

  void addDeviceParam({
    required String name,
    required String shortName,
    required String shortNameDescription,
    required String unit,
  }) {
    _deviceParams.add(DeviceParams(
        name: name,
        shortName: shortName,
        unit: unit,
        shortNameDescription: shortNameDescription));
    notifyListeners();
  }

  void updateDeviceParam({
    required String id,
    required String name,
    required String shortName,
    required String shortNameDescription,
    required String unit,
  }) {
    _deviceParams.forEach((el) => {
          if (el.id == id)
            {
              el.name = (name == null || name.isEmpty) ? el.name : name,
              el.shortName = (shortName == null || shortName.isEmpty)
                  ? el.shortName
                  : shortName,
              el.unit = (unit == null || unit.isEmpty) ? el.unit : unit,
              el.shortNameDescription =
                  (shortNameDescription == null || shortNameDescription.isEmpty)
                      ? el.shortNameDescription
                      : shortNameDescription
            }
        });
    notifyListeners();
  }

  void removeDeviceParam({
    required String id,
  }) {
    int index = _deviceParams.indexWhere((element) => element.id == id);
    _deviceParams.removeAt(index);
    notifyListeners();
  }

  void _init() async {
    final data = await _appStore.readFirstAppProviderData();
    setDeviceName(data.deviceName);
    setDevicesCount(data.deviceCount);
  }
}
