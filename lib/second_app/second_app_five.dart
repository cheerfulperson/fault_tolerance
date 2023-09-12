import 'package:Method/providers/second_app_providers.dart';
import 'package:Method/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  double? t = 0;
  String resultText = '';
  final _formKey = GlobalKey<FormState>();
  final _valueDebouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SecondAppProvider>();
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
                                'Время наработки t, ч:',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '** Пожалуйста, введите значение',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: 720,
                                child: TextFormField(
                                  style: TextStyle(fontSize: 20, height: 1),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(gapPadding: 2),
                                    hintText: '15',
                                    hintStyle: TextStyle(fontSize: 20),
                                    labelStyle: TextStyle(fontSize: 2),
                                  ),
                                  initialValue: provider.workTime.toString(),
                                  onChanged: (value) {
                                    _valueDebouncer.run(() {
                                      provider.setWorkTime(double.tryParse(
                                              value.replaceAll(',', '.')) ??
                                          0);
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
                      'Значение имитационного фактора БУКВА: ${(provider.appResults)}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText.rich(TextSpan(
                        text:
                            '** Если результатом является значение null, то какая-то формула в программе введена неверно')),
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
