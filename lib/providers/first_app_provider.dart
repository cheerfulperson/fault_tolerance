import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:Method/providers/store.dart';

const Uuid uuid = Uuid();

class DeviceParams {
  DeviceParams(
      {required this.name, required this.shortName, required this.value});
  String id = uuid.v4();
  String name;
  String shortName;
  String value;
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
    required String value,
  }) {
    _deviceParams
        .add(DeviceParams(name: name, shortName: shortName, value: value));
    notifyListeners();
  }

  void updateDeviceParam({
    required String id,
    String? name,
    String? shortName,
    String? value,
  }) {
    _deviceParams.forEach((el) => {
          if (el.id == id)
            {
              el.name = (name == null || name.isEmpty) ? el.name : name,
              el.shortName = (shortName == null || shortName.isEmpty)
                  ? el.shortName
                  : shortName,
              el.value = (value == null || value.isEmpty) ? el.value : value
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
