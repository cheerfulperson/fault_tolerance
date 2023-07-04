import 'package:Method/first_app/first_app.dart';
import 'package:Method/providers/first_app_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataTableFOs extends StatefulWidget {
  DataTableFOs({
    super.key,
    required this.deviceFOs,
    required this.isSortedFos,
  });
  List<FO> deviceFOs = [];
  bool isSortedFos;

  @override
  State<DataTableFOs> createState() => _DataTableFOsState();
}

class _DataTableFOsState extends State<DataTableFOs> {
  int index = 0;
  TableRow getRow(FO data) {
    index++;
    return TableRow(
      children: [
        Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1), bottom: BorderSide(width: 1))),
            child: Text(
              (index).toString(),
              style: TextStyle(fontSize: 20),
            )),
        Container(
          height: 32,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                  right: BorderSide(width: 1))),
          child: ElemParams(paramsValue: data.params),
        ),
        Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1), bottom: BorderSide(width: 1))),
          child: DropdownButtonFormField<String>(
              value: data.number,
              isExpanded: true,
              style: TextStyle(fontSize: 20, height: 1),
              icon: Icon(Icons.arrow_drop_down),
              alignment: Alignment.center,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(bottom: 12, left: 8, right: 8),
                  hoverColor: Color.fromARGB(255, 255, 255, 255),
                  border: InputBorder.none,
                  fillColor: Color.fromRGBO(238, 238, 238, 1),
                  focusColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black26),
                  labelStyle: TextStyle(fontSize: 20)),
              items: [
                DropdownMenuItem(
                  child: Text('', style: TextStyle(color: Colors.black)),
                  alignment: Alignment.center,
                  value: '',
                ),
                DropdownMenuItem(
                  child: Text('0', style: TextStyle(color: Colors.black)),
                  alignment: Alignment.center,
                  value: '0',
                ),
                DropdownMenuItem(
                  child: Text('1', style: TextStyle(color: Colors.black)),
                  alignment: Alignment.center,
                  value: '1',
                )
              ],
              onChanged: (e) {
                data.number = e ?? '';
              }),
        )
      ],
    );
  }

  List<TableRow> getTableRows() {
    index = 0;
    if (widget.isSortedFos) {
      List<TableRow> k1 = widget.deviceFOs
          .where((element) => element.number == '1')
          .map<TableRow>(getRow)
          .toList();
      index = 0;
      List<TableRow> k0 = widget.deviceFOs
          .where((element) => element.number == '0')
          .map<TableRow>(getRow)
          .toList();
      return [
        TableRow(
          children: [
            Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('')),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1),
              )),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Экземпляры класса K'),
                TextSpan(text: '1', style: TextStyle(fontSize: 12))
              ], style: TextStyle(color: Colors.black, fontSize: 18))),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1),
                      bottom: BorderSide(width: 1))),
              child: Text(''),
            )
          ],
        ),
        ...k1,
        TableRow(
          children: [
            Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1),
                        bottom: BorderSide(width: 1))),
                child: Text('')),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1),
              )),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Экземпляры класса K'),
                TextSpan(text: '0', style: TextStyle(fontSize: 12))
              ], style: TextStyle(color: Colors.black, fontSize: 18))),
            ),
            Container(
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1),
                      bottom: BorderSide(width: 1))),
              child: Text(''),
            )
          ],
        ),
        ...k0
      ];
    }
    return widget.deviceFOs.map<TableRow>(getRow).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(160),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(200),
        },
        children: getTableRows());
  }
}

class ElemParams extends StatelessWidget {
  ElemParams({
    super.key,
    required this.paramsValue,
  });

  List<DeviceParamValue> paramsValue;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: paramsValue.map((data) {
      index += 1;
      return Expanded(
          child: Container(
        height: 31,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(width: index == paramsValue.length ? 0 : 1))),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          initialValue: (data.value).toString(),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
            TextInputFormatter.withFunction((oldValue, newValue) {
              List<String> replacedValue =
                  newValue.text.replaceAll(',', '.').split('.');
              return replacedValue.length > 2 ? oldValue : newValue;
            }),
            NumericalRangeFormatter(max: 100000, min: -100000),
          ],
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              data.value = double.parse(value.replaceAll(',', '.')).toString();
            } catch (e) {
              data.value = '0';
            }
          },
          style: const TextStyle(
            fontSize: 20,
            height: 1,
          ),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 14),
              hoverColor: Color(0xFF455A64),
              border: InputBorder.none,
              hintText: '0',
              hintStyle: TextStyle(color: Colors.black26),
              labelStyle: TextStyle(fontSize: 20)),
        ),
      ));
    }).toList());
  }
}
