import 'package:flutter/material.dart';
import '../routes.dart';
import 'components/header.dart';
import 'components/nav_bar.dart';

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

  int t = 0;
  String resultText = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppHeaderBar(nextPage: ''),
      body: Center(
        child: Column(
          children: <Widget>[
            SecondAppNavBar(),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Введите время наработки t:',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '10',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      t = int.tryParse(value) ?? 0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      //
                      // расчитываем по формуле (5), какому Ik эквивалентна эта наработка
                      //по формуле 2 рассчитываем интересующий параметр P
                      //Затем выводится полученное значение интересующего параметра P.
                      'Результат: $t',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
