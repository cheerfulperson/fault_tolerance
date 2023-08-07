import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';

class FirstAppResults extends StatefulWidget {
  const FirstAppResults({super.key, required this.title});
  final String title;

  @override
  State<FirstAppResults> createState() => _FirstAppResultsState();
}

class _FirstAppResultsState extends State<FirstAppResults> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void submitForm(Function cb) {
    if (_formKey.currentState!.validate()) {
      cb();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Quality quality = context.watch<FirstAppProvider>().getQuality();

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
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                                TextSpan(
                                    text: '1', style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - n'),
                                TextSpan(
                                    text: '1→1',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(text: ' = ${quality.n11}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Количество правильно распознанных по прогнозу экземпляров в классе K'),
                                TextSpan(
                                    text: '0', style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - n'),
                                TextSpan(
                                    text: '0→0',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(text: ' = ${quality.n00}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Вероятность принятия правильных решений по прогнозу P'),
                                TextSpan(
                                    text: 'прав',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(text: ' для всей обучающей выборки'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'прав',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text:
                                        ' = ${quality.Pprav.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Вероятность принятия по прогнозу ошибочных решений P'),
                                TextSpan(
                                    text: 'ош', style: TextStyle(fontSize: 12)),
                                TextSpan(text: ' для всей обучающей выборки'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'ош', style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text:
                                        ' = ${quality.Poh.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Вероятность правильного прогноза экземпляров класса K'),
                                TextSpan(
                                    text: '1', style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'прав',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(text: '(K'),
                                TextSpan(
                                    text: '1', style: TextStyle(fontSize: 12)),
                                TextSpan(text: ')'),
                                TextSpan(
                                    text:
                                        ' = ${quality.PpravK1.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'Вероятность правильного прогноза экземпляров класса K'),
                                TextSpan(
                                    text: '0', style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'прав',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(text: '(K'),
                                TextSpan(
                                    text: '0', style: TextStyle(fontSize: 12)),
                                TextSpan(text: ')'),
                                TextSpan(
                                    text:
                                        ' = ${quality.PpravK0.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: 'Риск потребителя P'),
                                TextSpan(
                                    text: 'потреб',
                                    style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'потреб',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text:
                                        ' = ${quality.Ppotreb.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: 'Риск изготовителя P'),
                                TextSpan(
                                    text: 'изгот',
                                    style: TextStyle(fontSize: 12)),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: ' - P'),
                                TextSpan(
                                    text: 'изгот',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text:
                                        ' = ${quality.Pizgot.toStringAsFixed(3)}'),
                              ],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      ]),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
