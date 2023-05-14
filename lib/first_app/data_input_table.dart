import 'package:flutter/material.dart';

import '../components/app_header.dart';

class DataInputTable extends StatefulWidget {
  const DataInputTable({super.key, required this.title});
  final String title;

  @override
  State<DataInputTable> createState() => _DataInputTableState();
}

class _DataInputTableState extends State<DataInputTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Исходные данные'),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.title}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}