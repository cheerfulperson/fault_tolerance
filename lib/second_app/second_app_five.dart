import 'package:flutter/material.dart';
import '../routes.dart';
import 'components/header.dart';

class SecondAppDataFieldsFivePage extends StatefulWidget {
  final String title;

  const SecondAppDataFieldsFivePage({Key? key, required this.title})
      : super(key: key);

  @override
  _SecondAppDataFieldsFivePageState createState() =>
      _SecondAppDataFieldsFivePageState();
}

class _SecondAppDataFieldsFivePageState
    extends State<SecondAppDataFieldsFivePage> {
  String t = '';
  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Пятая страница',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  t = value;
                  resultText = 'Результат для t = $t: 20 лет';
                });
              },
              decoration: InputDecoration(
                labelText: 'Введите значение для t',
              ),
            ),
            SizedBox(height: 20),
            Text(
              resultText,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
