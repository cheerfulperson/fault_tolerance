import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/debounce.dart';

class SecondApp extends StatefulWidget {
  const SecondApp({super.key, required this.title});
  final String title;

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void submitForm(Function cb) {
    if (_formKey.currentState!.validate()) {
      cb();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final _nameDebouncer = Debouncer(milliseconds: 5000);
    final _countDebouncer = Debouncer(milliseconds: 3000);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          TextButton(
            onPressed: () {
              print('Hello');
            },
            child: Text(
              'Нажми меня',
              style: TextStyle(color: Colors.black12),
            ),
            style: TextButton.styleFrom(
                side: BorderSide(color: Colors.black, width: 1)),
          )
        ],
      ),
    );
  }
}

enum FieldKey { name, shortName, value }
