import 'dart:math';

import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:Method/providers/store.dart';
import 'package:Method/utils/app_math.dart';
import './first_app_elements.dart';

const Uuid uuid = Uuid();

enum ParamClass { first, second }

enum EClientActions {
  nameChanged,
  countChanged,
  addDeviceParam,
  updateDeviceParam,
  deleteDeviceParam,
  generateFOs,
  navigation,
  updateFoNumber,
  updateFoParams,
}

class ClientAction {
  ClientAction({required this.action, required this.data});

  EClientActions action;
  Map<String, dynamic> data;
}

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['shortNameDescription'] = this.shortNameDescription;
    data['unit'] = this.unit;

    return data;
  }
}

class PrivateInfo {
  PrivateInfo({
    required this.nK1t1,
    required this.nK1t0,
    required this.nK1tR,
    required this.nK0t1,
    required this.nK0t0,
    required this.nK0tR,
    required this.nt1,
    required this.nt0,
    required this.ntR,
  });
  List<double> nK1t1;
  List<double> nK1t0;
  List<double> nK1tR;
  List<double> nK0t1;
  List<double> nK0t0;
  List<double> nK0tR;
  List<double> nt1;
  List<double> nt0;
  List<double> ntR;
}

class Quality {
  Quality({
    required this.n11,
    required this.n00,
    required this.Pprav,
    required this.Poh,
    required this.PpravK1,
    required this.PpravK0,
    required this.Ppotreb,
    required this.Pizgot,
  });

  int n11;
  int n00;
  double Pprav;
  double Poh;
  double PpravK1;
  double PpravK0;
  double Ppotreb;
  double Pizgot;

  Map<String, dynamic> toJson() => {
        'n11': n11,
        'n00': n00,
        'Pprav': Pprav,
        'Poh': Poh,
        'PpravK1': PpravK1,
        'PpravK0': PpravK0,
        'Ppotreb': Ppotreb,
        'Pizgot': Pizgot,
      };
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramId'] = this.paramId;
    data['value'] = this.value;

    return data;
  }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['number'] = this.number;
    data['params'] = this.params.map((e) => e.toJson()).toList();

    return data;
  }
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

  final AppStorage _store = AppStorage();
  final List<DeviceParams> _deviceParams = [];
  List<FO> _deviceFOs = [];
  List<ClientAction> _actions = [];
  List<TableRow> _deviceRows = [];
  String _deviceName = '';
  int _deviceCount = 10;
  bool _isSortedFos = false;
  bool _isSmthChanged = false;

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
  @override
  bool get isSmthChanged => _isSmthChanged;

  void addAction(
      {required EClientActions action, required Map<String, dynamic> data}) {
    if (_actions.length >= 20) {
      _actions.removeAt(0);
    }
    _actions.add(ClientAction(action: action, data: data));
  }

  void undoLastAction({BuildContext? context}) {
    if (_actions.length <= 0) {
      return;
    }
    ClientAction lastAction = _actions.elementAt(_actions.length - 1);
    _actions.removeAt(_actions.length - 1);

    if (context != null) {
      if (lastAction.action == EClientActions.generateFOs ||
          lastAction.action == EClientActions.updateFoNumber ||
          lastAction.action == EClientActions.updateFoParams) {
        Navigator.pushNamed(context, firstAppSecondRoute);
      } else {
        Navigator.pushNamed(context, firstAppRoute);
      }
    }

    switch (lastAction.action) {
      case EClientActions.nameChanged:
        if (lastAction != null) {
          _deviceName = lastAction.data['name'];
        } else {
          _deviceName = '';
        }
        break;
      case EClientActions.countChanged:
        if (lastAction != null) {
          _deviceCount = lastAction.data['count'];
        } else {
          _deviceCount = 10;
        }
        break;
      case EClientActions.addDeviceParam:
        removeDeviceParam(id: lastAction.data['id'], isAddAction: false);
        break;
      case EClientActions.updateDeviceParam:
        String id = lastAction.data['id'];
        String name = lastAction.data['name'];
        String shortName = lastAction.data['shortName'];
        String shortNameDescription = lastAction.data['shortNameDescription'];
        String unit = lastAction.data['unit'];
        updateDeviceParam(
            id: id,
            name: name,
            shortName: shortName,
            shortNameDescription: shortNameDescription,
            unit: unit,
            isAddAction: false);
        break;
      case EClientActions.deleteDeviceParam:
        String name = lastAction.data['name'];
        String shortName = lastAction.data['shortName'];
        String shortNameDescription = lastAction.data['shortNameDescription'];
        String unit = lastAction.data['unit'];
        addDeviceParam(
            name: name,
            shortName: shortName,
            shortNameDescription: shortNameDescription,
            unit: unit,
            isAddAction: false);
        break;
      case EClientActions.generateFOs:
        _deviceFOs.clear();
        _deviceFOs = lastAction.data['deviceFOs'];
        break;
      case EClientActions.navigation:
        String name = lastAction.data['route'];
        if (context != null) {
          Navigator.pushNamed(context, name);
        }
        break;
      case EClientActions.updateFoNumber:
        String number = lastAction.data['number'];
        int? index = int.tryParse(lastAction.data['index']);
        if (index != null) {
          _deviceFOs[index].number = number;
        }
        break;
      case EClientActions.updateFoParams:
        String paramValue = lastAction.data['paramValue'];
        String paramId = lastAction.data['paramId'];
        int? index = int.tryParse(lastAction.data['index']);
        if (index != null) {
          _deviceFOs[index].params.forEach((el) {
            if (el.paramId == paramId) {
              el.value = paramValue;
            }
          });
        }
        break;
      default:
        return;
    }

    notifyListeners();
  }

  void setDeviceName(String name) {
    addAction(action: EClientActions.nameChanged, data: {'name': _deviceName});
    _deviceName = name;
    _isSmthChanged = true;
    notifyListeners();
  }

  void setSortedFos(bool isSortedFos) {
    _isSortedFos = isSortedFos;
    _isSmthChanged = true;
    notifyListeners();
  }

  void setDevicesCount(int count) {
    if (count > 1000 || count < 5) {
      return;
    }
    _isSmthChanged = true;
    addAction(
        action: EClientActions.countChanged, data: {'count': _deviceCount});
    _deviceCount = count;
    generateDeviceFOs(isEmpty: true);
    notifyListeners();
  }

  void generateDeviceFOs({required bool isEmpty, void Function()? cb}) {
    var rng = Random();
    if (_deviceFOs.length > 0) {
      addAction(action: EClientActions.generateFOs, data: {
        'deviceFOs': [..._deviceFOs]
      });
    }
    _isSmthChanged = true;
    _deviceFOs.clear();
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

    if (cb != null) {
      cb();
    }
  }

  void updateDeviceFOs(List<FO> devices) {
    _isSmthChanged = true;
    devices.forEach((element) {
      _deviceFOs[int.parse(element.index)] = element;
    });
  }

  void addDeviceParam({
    required String name,
    required String shortName,
    required String shortNameDescription,
    required String unit,
    bool isAddAction = true,
  }) {
    if (_deviceParams.length == 0 && _deviceFOs.length == 0) {
      generateDeviceFOs(isEmpty: true);
    }
    _isSmthChanged = true;
    DeviceParams param = DeviceParams(
        name: name,
        shortName: shortName,
        unit: unit,
        shortNameDescription: shortNameDescription);
    _deviceParams.add(param);
    _deviceFOs.forEach((element) {
      element.params.add(DeviceParamValue(paramId: param.id, value: ''));
    });
    if (isAddAction) {
      addAction(action: EClientActions.addDeviceParam, data: {'id': param.id});
    }
    notifyListeners();
  }

  void updateDeviceParam({
    required String id,
    required String name,
    required String shortName,
    required String shortNameDescription,
    required String unit,
    bool isAddAction = true,
  }) {
    _isSmthChanged = true;
    _deviceParams.forEach((el) {
      if (el.id == id) {
        if (isAddAction) {
          this.addAction(action: EClientActions.updateDeviceParam, data: {
            'id': el.id,
            'name': el.name,
            'shortName': el.shortName,
            'shortNameDescription': el.shortNameDescription,
            'unit': el.unit
          });
        }
        el.name = (name == null || name.isEmpty) ? el.name : name;
        el.shortName =
            (shortName == null || shortName.isEmpty) ? el.shortName : shortName;
        el.unit = (unit == null || unit.isEmpty) ? el.unit : unit;
        el.shortNameDescription =
            (shortNameDescription == null || shortNameDescription.isEmpty)
                ? el.shortNameDescription
                : shortNameDescription;
      }
    });
    notifyListeners();
  }

  void removeDeviceParam({
    required String id,
    bool isAddAction = true,
  }) {
    int index = _deviceParams.indexWhere((element) => element.id == id);
    DeviceParams el = _deviceParams.elementAt(index);
    if (isAddAction) {
      this.addAction(action: EClientActions.deleteDeviceParam, data: {
        'id': el.id,
        'name': el.name,
        'shortName': el.shortName,
        'shortNameDescription': el.shortNameDescription,
        'unit': el.unit,
        'index': index,
      });
    }
    _isSmthChanged = true;
    this._deviceFOs.forEach((element) {
      element.params.removeAt(index);
    });
    _deviceParams.removeAt(index);
    notifyListeners();
  }

  List<FO> getPrivateInfoFOs(PrivateInfo info) {
    List<CenteredValue> centeredVales =
        this.deviceParams.map((e) => this.getCenteredValues(e.id)).toList();
    int k1 = this.deviceFOs.where((element) => element.number == '1').length;
    int k0 = this.deviceFOs.where((element) => element.number == '0').length;
    double P1 = (k1 / this.deviceCount);
    double P0 = (k0 / this.deviceCount);

    return this.deviceFOs.map((fo) {
      List<DeviceParamValue> newParams = [];
      int index = 0;
      double I1 = 0;
      double I0 = 0;
      double sum = 0;

      fo.params.forEach((element) {
        String param =
            getParam(data: centeredVales[index], value: element.value);
        double i1Result = 1;
        double i0Result = 1;

        if (param == '1') {
          i1Result = info.nK1t1[index] / P1;
          i0Result = info.nK0t1[index] / P0;
        } else if (param == '0') {
          i1Result = info.nK1t0[index] / P1;
          i0Result = info.nK0t0[index] / P0;
        } else {
          i1Result = info.nK1tR[index] / P1;
          i0Result = info.nK0tR[index] / P0;
        }
        I1 += log2(i1Result == 0 ? 1 : i1Result);
        I0 += log2(i0Result == 0 ? 1 : i0Result);
        sum = I1 - I0;
        index++;
      });

      newParams
          .add(DeviceParamValue(paramId: '1', value: I1.toStringAsFixed(3)));
      newParams
          .add(DeviceParamValue(paramId: '0', value: I0.toStringAsFixed(3)));
      newParams
          .add(DeviceParamValue(paramId: 'SUM', value: sum.toStringAsFixed(3)));
      return FO(index: fo.index, params: newParams, number: fo.number);
    }).toList();
  }

  List<FO> getLogicFOs(
      {required List<FO> fos, ParamClass paramClass = ParamClass.first}) {
    List<String> filtersValues = [];
    int index = 0;
    return fos
        .where((element) => paramClass == ParamClass.first
            ? element.number == '1'
            : element.number == '0')
        .map((e) {
      int paramIndex = 0;
      FO fo = _deviceFOs[int.tryParse(e.index) ?? index];
      List<CenteredValue> center =
          fo.params.map((e) => getCenteredValues(e.paramId)).toList();
      List<DeviceParamValue> params = center.map((e) {
        DeviceParamValue param = DeviceParamValue(
            paramId: e.paramId,
            value: getParam(data: e, value: fo.params[paramIndex].value));
        paramIndex++;
        return param;
      }).toList();
      index++;
      return FO(index: e.index, params: params, number: e.params[2].value);
    }).where((element) {
      double number = double.tryParse(element.number) ?? -1;
      String isHere = filtersValues.firstWhere(
        (elem) => elem == element.params.map((e) => '${e.value}'),
        orElse: () => '',
      );
      return isHere == '' &&
          (paramClass == ParamClass.first ? number >= 0 : number <= 0);
    }).toList();
  }

  String getParam({String value = '0', required CenteredValue data}) {
    try {
      double k1 = double.parse(data.k1);
      double k0 = double.parse(data.k0);
      double parsedValue = double.parse(value);
      bool isK1Biggger = k0 < k1;
      if (isK1Biggger) {
        if (parsedValue > k1) {
          return '1';
        }
        if (parsedValue < k0) {
          return '0';
        }
        return 'R';
      }
      if (parsedValue > k0) {
        return '1';
      }
      if (parsedValue < k1) {
        return '0';
      }
      return 'R';
    } catch (e) {
      return 'R';
    }
  }

  List<PrivateInfo> getPrivateInfoNumber() {
    List<CenteredValue> centeredVales =
        this.deviceParams.map((e) => this.getCenteredValues(e.id)).toList();
    List<double> reversed = this.deviceParams.map<double>((e) => 0).toList();
    List<double> nK1t1 = [...reversed];
    List<double> nK1t0 = [...reversed];
    List<double> nK1tR = [...reversed];
    List<double> nK0t1 = [...reversed];
    List<double> nK0t0 = [...reversed];
    List<double> nK0tR = [...reversed];
    List<double> nt1 = [...reversed];
    List<double> nt0 = [...reversed];
    List<double> ntR = [...reversed];

    this.deviceFOs.forEach((fo) {
      int index = 0;
      fo.params.forEach((element) {
        String param =
            getParam(data: centeredVales[index], value: element.value);
        if (nK1t1[index] == null) {
          nK1t1[index] = 0;
        }
        if (fo.number == '1') {
          if (param == '1') {
            nK1t1[index] += 1;
          } else if (param == '0') {
            nK1t0[index] += 1;
          } else {
            nK1tR[index] += 1;
          }
        } else {
          if (param == '1') {
            nK0t1[index] += 1;
          } else if (param == '0') {
            nK0t0[index] += 1;
          } else {
            nK0tR[index] += 1;
          }
        }
        index++;
      });
    });
    int index = 0;
    nK1t1.forEach((element) {
      nt1[index] = nK1t1[index] + nK0t1[index];
      nt0[index] = nK1t0[index] + nK0t0[index];
      ntR[index] = nK1tR[index] + nK0tR[index];
      index++;
    });
    PrivateInfo info = PrivateInfo(
        nK1t1: nK1t1,
        nK1t0: nK1t0,
        nK1tR: nK1tR,
        nK0t1: nK0t1,
        nK0t0: nK0t0,
        nK0tR: nK0tR,
        nt1: nt1,
        nt0: nt0,
        ntR: ntR);

    List<double> private_nK1t1 = [...nK1t1];
    List<double> private_nK1t0 = [...nK1t0];
    List<double> private_nK1tR = [...nK1tR];
    List<double> private_nK0t1 = [...nK0t1];
    List<double> private_nK0t0 = [...nK0t0];
    List<double> private_nK0tR = [...nK0tR];
    List<double> private_nt1 = [...nt1];
    List<double> private_nt0 = [...nt0];
    List<double> private_ntR = [...ntR];
    int jdex = 0;
    private_nK1t1.forEach((element) {
      double del1 = private_nt1[jdex] == 0 ? 1 : private_nt1[jdex];
      double del0 = private_nt0[jdex] == 0 ? 1 : private_nt0[jdex];
      double delR = private_ntR[jdex] == 0 ? 1 : private_ntR[jdex];
      private_nK1t1[jdex] = private_nK1t1[jdex] / del1;
      private_nK1t0[jdex] = private_nK1t0[jdex] / del0;
      private_nK1tR[jdex] = private_nK1tR[jdex] / delR;
      private_nK0t1[jdex] = private_nK0t1[jdex] / del1;
      private_nK0t0[jdex] = private_nK0t0[jdex] / del0;
      private_nK0tR[jdex] = private_nK0tR[jdex] / delR;
      private_nt1[jdex] = private_nt1[jdex] / this.deviceCount;
      private_nt0[jdex] = private_nt0[jdex] / this.deviceCount;
      private_ntR[jdex] = private_ntR[jdex] / this.deviceCount;
      jdex++;
    });
    PrivateInfo privateInfo = PrivateInfo(
        nK1t1: private_nK1t1,
        nK1t0: private_nK1t0,
        nK1tR: private_nK1tR,
        nK0t1: private_nK0t1,
        nK0t0: private_nK0t0,
        nK0tR: private_nK0tR,
        nt1: private_nt1,
        nt0: private_nt0,
        ntR: private_ntR);
    return [info, privateInfo];
  }

  Quality getQuality() {
    List<PrivateInfo> info = getPrivateInfoNumber();
    List<FO> privateInfo = getPrivateInfoFOs(info[1]);
    int k1Length = this
        .deviceFOs
        .where((element) => element.number == '1')
        .toList()
        .length;
    int k0Length = this
        .deviceFOs
        .where((element) => element.number == '0')
        .toList()
        .length;

    int n11 =
        getLogicFOs(fos: privateInfo, paramClass: ParamClass.first).length;
    int n00 =
        getLogicFOs(fos: privateInfo, paramClass: ParamClass.second).length;

    double Pprav = (n11 + n00) / (this.deviceCount == 0 ? 1 : this.deviceCount);
    double Poh = 1 - Pprav;
    double PpravK1 = n11 / k1Length;
    double PpravK0 = n00 / k0Length;
    double Ppotreb = (k0Length - n00) / (n11 + (k0Length - n00));
    double Pizgot = (k1Length - n11) / (n00 + (k1Length - n11));
    return Quality(
        n11: n11,
        n00: n00,
        Pprav: Pprav,
        Poh: Poh,
        PpravK1: PpravK1,
        PpravK0: PpravK0,
        Ppotreb: Ppotreb,
        Pizgot: Pizgot);
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

  Future<void> saveToFile({bool isNeedNewPath = false}) async {
    if (!_isSmthChanged && !isNeedNewPath) {
      return;
    }

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = _deviceName;
    data['deviceCount'] = _deviceCount;
    data['deviceParams'] = _deviceParams.map((e) => e.toJson()).toList();
    data['deviceFOs'] = _deviceFOs.map((e) => e.toJson()).toList();
    data['isSortedFos'] = _isSortedFos;
    _isSmthChanged = false;

    await _store.saveToFile(data: data, isNeedNewPath: isNeedNewPath);
    notifyListeners();
  }

  Future<void> importData() async {
    try {
      Map<String, dynamic>? data = await _store.getDataFromFile();
      print(data);
      if (data == null) {
        return;
      }
      List<dynamic> deviceParams = data['deviceParams'];
      List<dynamic> deviceFOs = data['deviceFOs'];
      _deviceName = data['deviceName'];
      _deviceCount = data['deviceCount'];
      _isSortedFos = data['isSortedFos'];
      _deviceParams.clear();
      deviceParams.forEach((e) {
        DeviceParams param = DeviceParams(
            name: e['name'],
            shortName: e['shortName'],
            unit: e['unit'],
            number: e['number'],
            shortNameDescription: e['shortNameDescription']);
        param.id = e['id'];
        print(param);
        _deviceParams.add(param);
      });
      _deviceFOs = deviceFOs.map((e) {
        List<dynamic> params = e['params'];
        FO fo = FO(
            index: e['index'],
            params: params
                .map((e) =>
                    DeviceParamValue(paramId: e['paramId'], value: e['value']))
                .toList(),
            number: e['number']);
        return fo;
      }).toList();
      notifyListeners();
    } catch (e) {}
  }

  void _init() async {
    // final data = await _appStore.readFirstAppProviderData();
    // setDeviceName(data.deviceName);
    // setDevicesCount(data.deviceCount);
  }
}
