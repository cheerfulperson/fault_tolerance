import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/debounce.dart';
import 'components/header.dart';
import 'components/nav_bar.dart';
import './first_app.utils.dart';

class UnDoSecondAppAction extends Intent {
  const UnDoSecondAppAction();
}

class FirstApp extends StatefulWidget {
  const FirstApp({super.key, required this.title});
  final String title;

  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _finalCountController = TextEditingController();

  late FocusNode _node;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String deviceName = '';

  void submitForm(Function cb) {
    if (_formKey.currentState!.validate()) {
      cb();
    }
  }

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Focus');

    final String text =
        Provider.of<FirstAppProvider>(context, listen: false).deviceName;
    final String count = Provider.of<FirstAppProvider>(context, listen: false)
        .deviceCount
        .toStringAsFixed(0);
    final String finalDeviceCount =
        Provider.of<FirstAppProvider>(context, listen: false)
            .finalDeviceCount
            .toStringAsFixed(0);
    _nameController.value = _nameController.value.copyWith(
      text: text,
      selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
    _countController.value = _countController.value.copyWith(
      text: count,
      selection:
          TextSelection(baseOffset: count.length, extentOffset: count.length),
      composing: TextRange.empty,
    );
    _finalCountController.value = _finalCountController.value.copyWith(
      text: finalDeviceCount,
      selection: TextSelection(
          baseOffset: finalDeviceCount.length,
          extentOffset: finalDeviceCount.length),
      composing: TextRange.empty,
    );
    deviceName = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final _nameDebouncer = Debouncer(milliseconds: 1000);
    final _countDebouncer = Debouncer(milliseconds: 1200);
    final _finalCountDebouncer = Debouncer(milliseconds: 1000);

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirstAppNavBar(),
            // Added shortcuts to handle undo event
            Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.keyZ,
                      LogicalKeyboardKey.controlLeft): UnDoSecondAppAction(),
                },
                child: Actions(
                    actions: <Type, Action<Intent>>{
                      UnDoSecondAppAction: CallbackAction<UnDoSecondAppAction>(
                        onInvoke: (UnDoSecondAppAction intent) {
                          Provider.of<FirstAppProvider>(context, listen: false)
                              .undoLastAction(context: context);
                          setState(() {
                            final String text = Provider.of<FirstAppProvider>(
                                    context,
                                    listen: false)
                                .deviceName;
                            final String count = Provider.of<FirstAppProvider>(
                                    context,
                                    listen: false)
                                .deviceCount
                                .toStringAsFixed(0);
                            _nameController.value =
                                _nameController.value.copyWith(
                              text: text,
                              selection: TextSelection(
                                  baseOffset: text.length,
                                  extentOffset: text.length),
                              composing: TextRange.empty,
                            );
                            _countController.value =
                                _countController.value.copyWith(
                              text: count,
                              selection: TextSelection(
                                  baseOffset: count.length,
                                  extentOffset: count.length),
                              composing: TextRange.empty,
                            );
                          });
                        },
                      )
                    },
                    child: Focus(
                        autofocus: true, focusNode: _node, child: Text('')))),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Название прибора, который будет учавствовать в эксперементе:',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                          width: 720,
                                          child: TextFormField(
                                            controller: _nameController,
                                            keyboardType: TextInputType.text,
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value.length < 2) {
                                                return 'Пожалуйста введите правильное название';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              _nameDebouncer.run(() {
                                                context
                                                    .read<FirstAppProvider>()
                                                    .setDeviceName(value);
                                              });
                                              setState(() {
                                                deviceName = value;
                                              });
                                            },
                                            onTapOutside: (event) {
                                              _node.requestFocus();
                                            },
                                            style: TextStyle(
                                                fontSize: 20, height: 1),
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 0),
                                                hoverColor: Color(0xFF455A64),
                                                border: OutlineInputBorder(
                                                    gapPadding: 2),
                                                hintText: 'КТ872А',
                                                hintStyle: TextStyle(
                                                    color: Colors.black26),
                                                labelStyle:
                                                    TextStyle(fontSize: 20)),
                                          ))
                                    ]),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Объём обучающей выборки был определён в количестве (экземпляров):',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        '** Пожалуйста введите число от 5 до 1000',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                          width: 720,
                                          child: TextFormField(
                                            controller: _countController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              NumericalRangeFormatter(
                                                  max: 1000, min: 0)
                                            ],
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              _countDebouncer.run(() {
                                                try {
                                                  int newValue = value != ''
                                                      ? int.parse(value)
                                                      : 10;
                                                  context
                                                      .read<FirstAppProvider>()
                                                      .setDevicesCount(
                                                          newValue);
                                                } catch (e) {
                                                  _formKey.currentState!
                                                      .validate();
                                                }
                                              });
                                            },
                                            onTapOutside: (event) {
                                              _node.requestFocus();
                                            },
                                            style: const TextStyle(
                                              fontSize: 20,
                                              height: 1,
                                            ),
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 0),
                                                hoverColor: Color(0xFF455A64),
                                                border: OutlineInputBorder(
                                                    gapPadding: 2),
                                                hintText: '100',
                                                hintStyle: TextStyle(
                                                    color: Colors.black26),
                                                labelStyle:
                                                    TextStyle(fontSize: 20)),
                                          )),
                                    ]),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Объём контрольной выборки был определён в количестве (экземпляров):',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        '** Пожалуйста введите число от 5 до 1000',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                          width: 720,
                                          child: TextFormField(
                                            controller: _finalCountController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              NumericalRangeFormatter(
                                                  max: 1000, min: 0)
                                            ],
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              _finalCountDebouncer.run(() {
                                                try {
                                                  int newValue = value != ''
                                                      ? int.parse(value)
                                                      : 10;
                                                  context
                                                      .read<FirstAppProvider>()
                                                      .setFinalDevicesCount(
                                                          newValue);
                                                } catch (e) {
                                                  _formKey.currentState!
                                                      .validate();
                                                }
                                              });
                                            },
                                            onTapOutside: (event) {
                                              _node.requestFocus();
                                            },
                                            style: const TextStyle(
                                              fontSize: 20,
                                              height: 1,
                                            ),
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 0),
                                                hoverColor: Color(0xFF455A64),
                                                border: OutlineInputBorder(
                                                    gapPadding: 2),
                                                hintText: '100',
                                                hintStyle: TextStyle(
                                                    color: Colors.black26),
                                                labelStyle:
                                                    TextStyle(fontSize: 20)),
                                          )),
                                    ]),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Таблица 1 – Информативные параметры ППП',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: 720,
                                      child: Text(
                                          'В случае, если информативные параметры ППП $deviceName интересующего типа известны изначально, то рекомендуемое их число k выбирать от 2-х до 4-х. Если нет, то наиболее подходящие. Параметров может быть от 1 до 7 штук.',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ))),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TableWithParams(),
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              DialogAddParam(),
                                        ),
                                    child: const Text('Добавить параметр +'))
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
  TableWithParams({super.key});
  int index = 0;

  @override
  Widget build(BuildContext context) {
    index = 0;
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FixedColumnWidth(180),
        2: FixedColumnWidth(80),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: const Text('Название параметра',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: const Text('Обозначение',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: const Text('',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        ...context
            .watch<FirstAppProvider>()
            .deviceParams
            .map<TableRow>((param) {
          index += 1;
          return TableRow(
            children: <Widget>[
              TableInputRow(
                id: param.id,
                name: '${index.toString()}. ${param.name}',
              ),
              TableInputRow(
                  id: param.id,
                  shortName: param.shortName,
                  shortDescription: param.shortNameDescription,
                  unit: param.unit),
              RowActions(param: param),
            ],
          );
        })
      ],
    );
  }
}

class RowActions extends StatelessWidget {
  RowActions({
    super.key,
    required this.param,
  });

  final DeviceParams param;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        IconButton(
          onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => DialogAddParam(
                    param: this.param,
                  )),
          icon: Icon(
            Icons.edit,
            size: 24,
          ),
          iconSize: 24,
          style: IconButton.styleFrom(maximumSize: Size(24, 24)),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
        ),
        SizedBox(width: 16),
        IconButton(
          onPressed: () {
            context.read<FirstAppProvider>().removeDeviceParam(
                  id: this.param?.id ?? '',
                );
          },
          icon: Icon(
            Icons.delete,
            size: 24,
            color: Colors.red,
          ),
          iconSize: 24,
          style: IconButton.styleFrom(maximumSize: Size(24, 24)),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
        )
      ]),
    );
  }
}

class TableInputRow extends StatefulWidget {
  TableInputRow({
    super.key,
    required this.id,
    this.name = '',
    this.shortName = '',
    this.shortDescription = '',
    this.unit = '',
  });

  String id;
  String name;
  String shortName;
  String shortDescription;
  String unit;

  @override
  State<TableInputRow> createState() => _TableInputRowState();
}

class _TableInputRowState extends State<TableInputRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.shortName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Consolas',
                    fontStyle: FontStyle.italic),
              ),
              Text(
                widget.shortDescription,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Consolas',
                    fontStyle: FontStyle.italic),
              ),
              Text(widget.unit.isEmpty ? '' : ', ${widget.unit}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Consolas',
                      fontStyle: FontStyle.italic))
            ],
          )),
    );
  }
}

class DialogAddParam extends StatefulWidget {
  DialogAddParam({super.key, this.param});
  final DeviceParams? param;
  @override
  State<DialogAddParam> createState() => _DialogAddParamState();
}

class _DialogAddParamState extends State<DialogAddParam> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _shortNameDescriptionController;

  String _shortName = allSymbols[8];

  String _paramUnit = unitsOfMeasurement[8];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.param?.name ?? '');
    _shortNameDescriptionController =
        TextEditingController(text: widget.param?.shortNameDescription ?? '');
    setState(() {
      _shortName = widget.param?.shortName ?? allSymbols[8];
      _paramUnit = widget.param?.unit ?? unitsOfMeasurement[8];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 720,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Title(
                              color: Colors.black,
                              child: const Text(
                                'Добавление информативного параметра',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Полное название информативного параметра рабочего режима:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 2) {
                                      return 'Пожалуйста введите правильное название';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 0),
                                      hoverColor: Color(0xFF455A64),
                                      border: OutlineInputBorder(gapPadding: 2),
                                      hintText:
                                          'Статический коэффициент передачи тока',
                                      hintStyle:
                                          TextStyle(color: Colors.black26),
                                      labelStyle: TextStyle(fontSize: 20)),
                                )
                              ]),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Обозначение параметра:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                        width: 340,
                                        child: DropdownButtonFormField<String>(
                                          value: _shortName,
                                          items: allSymbols
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                      DropdownMenuItem<String>(
                                                        child: Text(value,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                        value: value,
                                                        alignment:
                                                            Alignment.center,
                                                      ))
                                              .toList(growable: false),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value != null) {
                                                _shortName = value;
                                              }
                                            });
                                          },
                                          style: TextStyle(
                                              fontSize: 20, height: 1),
                                          icon: Icon(Icons.arrow_drop_down),
                                          decoration: const InputDecoration(
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.center,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 0),
                                              hoverColor: Color(0xFF455A64),
                                              border: OutlineInputBorder(
                                                  gapPadding: 2),
                                              hintStyle: TextStyle(
                                                  color: Colors.black26),
                                              labelStyle:
                                                  TextStyle(fontSize: 20)),
                                        ))
                                  ]),
                              Spacer(),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Индекс параметра:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                        width: 320,
                                        child: TextFormField(
                                          controller:
                                              _shortNameDescriptionController,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(
                                              fontSize: 20, height: 1),
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 0),
                                              hoverColor: Color(0xFF455A64),
                                              border: OutlineInputBorder(
                                                  gapPadding: 2),
                                              hintText: 'кб.',
                                              hintStyle: TextStyle(
                                                  color: Colors.black26),
                                              labelStyle:
                                                  TextStyle(fontSize: 20)),
                                        ))
                                  ]),
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Единица измерений:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                            width: 340,
                            child: DropdownButtonFormField(
                              value: _paramUnit,
                              items: unitsOfMeasurement
                                  .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            child: Text(value,
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            value: value,
                                            alignment: Alignment.center,
                                          ))
                                  .toList(growable: false),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    _paramUnit = value;
                                  }
                                });
                              },
                              style: TextStyle(fontSize: 20, height: 1),
                              icon: Icon(Icons.arrow_drop_down),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  hoverColor: Color(0xFF455A64),
                                  border: OutlineInputBorder(gapPadding: 2),
                                  hintText: 'В',
                                  hintStyle: TextStyle(color: Colors.black26),
                                  labelStyle: TextStyle(fontSize: 20)),
                            ))
                      ]),
                  SizedBox(
                    height: 8,
                  ),
                  const Spacer(),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Отмена',
                              style: TextStyle(color: Colors.black)),
                          style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black, width: 1),
                              minimumSize: Size(240, 48)),
                        ),
                        const SizedBox(width: 48),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.param?.id != null) {
                                context
                                    .read<FirstAppProvider>()
                                    .updateDeviceParam(
                                        id: widget.param?.id ?? '',
                                        name: _nameController.text,
                                        shortName: _shortName,
                                        shortNameDescription:
                                            _shortNameDescriptionController
                                                .text,
                                        unit: _paramUnit);
                              } else {
                                context.read<FirstAppProvider>().addDeviceParam(
                                    name: _nameController.text,
                                    shortName: _shortName,
                                    shortNameDescription:
                                        _shortNameDescriptionController.text,
                                    unit: _paramUnit);
                              }
                              Navigator.pop(context, 'OK');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(240, 48)),
                          child: Text(widget.param?.id != null
                              ? 'Сохранить'
                              : 'Добавить'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
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
    }
    List<String> replacedValue = newValue.text.replaceAll(',', '.').split('.');
    String secondPart = replacedValue.skip(1).join('');
    String value =
        '${replacedValue.first}${secondPart.length > 0 ? '.' : ''}${secondPart}';
    try {
      double parsedValue = double.parse(value);
      if (parsedValue < min) {
        return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
      } else {
        return parsedValue > max ? oldValue : newValue;
      }
    } catch (e) {
      return newValue;
    }
  }
}
