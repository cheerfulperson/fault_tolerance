import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:Method/providers/store.dart';
import './first_app_elements.dart';

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

class CenteredValue {
  CenteredValue({required this.k1, required this.k0, required this.paramId});
  String paramId;
  String k1;
  String k0;
}

class DeviceParamValue {
  DeviceParamValue({
    required this.paramId,
    required this.value,
  });
  String paramId;
  String value;
}

class FO {
  FO({
    required this.index,
    required this.params,
    this.number = '',
  });
  String index;
  List<DeviceParamValue> params;
  String number;
}

class FirstAppState {
  int get deviceCount => 10;
  String get deviceName => '';
  List<DeviceParams> get deviceParams => [];
}

String getRandomValue() {
  var rgn = Random().nextInt(2);
  return rgn.toString();
}

class FirstAppProvider with ChangeNotifier implements FirstAppState {
  FirstAppProvider() {
    _init();
  }

  final AppStorage _appStore = AppStorage(fileName: 'first_app.json');
  final List<DeviceParams> _deviceParams = [];
  List<FO> _deviceFOs = [];
  List<TableRow> _deviceRows = [];
  String _deviceName = '';
  int _deviceCount = 10;
  bool _isSortedFos = false;

  @override
  int get deviceCount => _deviceCount;
  @override
  String get deviceName => _deviceName;
  @override
  List<DeviceParams> get deviceParams => _deviceParams;
  @override
  List<FO> get deviceFOs => _deviceFOs;
  @override
  bool get isSortedFos => _isSortedFos;

  Widget get TableFOs => DataTableFOs(
        deviceFOs: _deviceFOs,
        isSortedFos: _isSortedFos,
      );

  void setDeviceName(String name) {
    _deviceName = name;
    notifyListeners();
  }

  void setSortedFos(bool isSortedFos) {
    _isSortedFos = isSortedFos;
    notifyListeners();
  }

  void setDevicesCount(int count) {
    _deviceCount = count;
    generateDeviceFOs(true);
    notifyListeners();
  }

  void generateDeviceFOs(bool isEmpty) {
    var rng = Random();
    _deviceFOs = List<FO>.generate(deviceCount, (index) {
      return FO(
          index: index.toString(),
          params: List<DeviceParamValue>.generate(
              _deviceParams.length,
              (index) => DeviceParamValue(
                  paramId: _deviceParams[index].id,
                  value: isEmpty ? '' : (rng.nextInt(100) / 1000).toString())),
          number: isEmpty ? '0' : getRandomValue());
    });
  }

  void updateDeviceFOs(List<FO> devices) {
    devices.forEach((element) {
      _deviceFOs[int.parse(element.index)] = element;
    });
  }

  void addDeviceParam({
    required String name,
    required String shortName,
    required String shortNameDescription,
    required String unit,
  }) {
    DeviceParams param = DeviceParams(
        name: name,
        shortName: shortName,
        unit: unit,
        shortNameDescription: shortNameDescription);
    _deviceParams.add(param);
    _deviceFOs.forEach((element) {
      element.params.add(DeviceParamValue(paramId: param.id, value: ''));
    });
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

  CenteredValue getCenteredValues(String paramId) {
    List<DeviceParams> deviceParams = this.deviceParams;
    List<FO> k1 =
        this.deviceFOs.where((element) => element.number == '1').toList();
    List<FO> k0 =
        this.deviceFOs.where((element) => element.number == '0').toList();
    double value = 0.0;
    double valueK0 = 0.0;
    k1.forEach((element) {
      try {
        value += double.parse(element.params
            .where((element) => element.paramId == paramId)
            .first
            .value);
      } catch (e) {
        //no
      }
    });
    k0.forEach((element) {
      try {
        valueK0 += double.parse(element.params
            .where((element) => element.paramId == paramId)
            .first
            .value);
      } catch (e) {
        //no
      }
    });
    return CenteredValue(
        k1: (value / k1.length).toStringAsFixed(4),
        k0: (valueK0 / k0.length).toStringAsFixed(4),
        paramId: paramId);
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
