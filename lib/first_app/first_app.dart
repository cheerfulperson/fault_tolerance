import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';

class FirstApp extends StatefulWidget {
  const FirstApp({super.key, required this.title});
  final String title;

  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void submitForm(Function cb) {
    if (_formKey.currentState!.validate()) {
      cb();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirstAppNavBar(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: 1020,
                  height: screenHeight - 160,
                  child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8.0,
                      ),
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: (context
                                      .watch<FirstAppProvider>()
                                      .deviceName),
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 2) {
                                      return 'Пожалуйста введите правильное название';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => context
                                      .read<FirstAppProvider>()
                                      .setDeviceName(value),
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Навзание полупроводникового приборы',
                                      labelStyle: TextStyle(fontSize: 20)),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                    initialValue: (context
                                            .watch<FirstAppProvider>()
                                            .deviceCount)
                                        .toString(),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      NumericalRangeFormatter(
                                          max: 10000, min: 0)
                                    ],
                                    keyboardType: TextInputType.number,
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value == '0') {
                                        return 'Пожалуйста введите число от 1 до 10000';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      try {
                                        context
                                            .read<FirstAppProvider>()
                                            .setDevicesCount(value != ''
                                                ? int.parse(value)
                                                : 0);
                                      } catch (e) {
                                        _formKey.currentState!.validate();
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Количество экземпляров',
                                        labelStyle: TextStyle(fontSize: 20))),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Параметры рабочего режима транзисторов',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const TableWithParams(),
                                const SizedBox(
                                  height: 8,
                                ),
                                DialogAddParam()
                              ],
                            )),
                      ]),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

enum FieldKey { name, shortName, value }

class TableWithParams extends StatelessWidget {
  const TableWithParams({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FixedColumnWidth(180),
        2: FixedColumnWidth(180),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              child: const Text('Название параметра',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 32,
              child: const Text('Обозначение',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 32,
              child: const Text('Величина',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        ...context.watch<FirstAppProvider>().deviceParams.map<TableRow>(
              (param) => TableRow(
                children: <Widget>[
                  TableInputRow(
                      id: param.id, value: param.name, fieldKey: FieldKey.name),
                  TableInputRow(
                      id: param.id,
                      value: param.shortName,
                      fieldKey: FieldKey.shortName),
                  TableInputRow(
                      id: param.id,
                      value: param.value,
                      fieldKey: FieldKey.value),
                ],
              ),
            )
      ],
    );
  }
}

class TableInputRow extends StatefulWidget {
  TableInputRow({
    super.key,
    required this.id,
    this.value = '',
    this.fieldKey = FieldKey.name,
  });

  String id;
  String value;
  FieldKey fieldKey;

  @override
  State<TableInputRow> createState() => _TableInputRowState();
}

class _TableInputRowState extends State<TableInputRow> {
  void handleChange(String value) {
    context
        .read<FirstAppProvider>()
        .updateDeviceParam(id: widget.id, name:value);
  }

  @override
  Widget build(BuildContext context) {
    String v = widget.value;
    return Container(
      height: 48,
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextFormField(
            initialValue: widget.value,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration.collapsed(
                border: InputBorder.none, hintText: ''),
            validator: (String? value) {
              if (value == null || value.isEmpty || value.length < 2) {
                return '';
              }
              return null;
            },
            onEditingComplete: () {
              handleChange(v);
            },
            onChanged: (newValue) {
              v = newValue;
            },
          )),
    );
  }
}

class DialogAddParam extends StatelessWidget {
  DialogAddParam({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final shortNameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 720,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Title(
                                    color: Colors.black,
                                    child: const Text(
                                      'Заполните все поля',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    )),
                                TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 2) {
                                      return 'Пожалуйста введите правильное название';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Название параметра рабочего режима',
                                      labelStyle: TextStyle(fontSize: 20)),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  controller: shortNameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Пожалуйста введите правильное обозначение';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Обозначение параметра',
                                      labelStyle: TextStyle(fontSize: 20)),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  controller: valueController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Пожалуйста введите правильную величину';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Величина параметра',
                                      labelStyle: TextStyle(fontSize: 20)),
                                ),
                              ],
                            )),
                        const Spacer(),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Отмена'),
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      context
                                          .read<FirstAppProvider>()
                                          .addDeviceParam(
                                              name: nameController.text,
                                              shortName:
                                                  shortNameController.text,
                                              value: valueController.text),
                                      Navigator.pop(context, 'OK'),
                                    }
                                },
                                child: const Text('Добавить'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
      child: const Text('Добавить параметр +'),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
