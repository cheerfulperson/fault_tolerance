import 'dart:io';

import 'package:Method/routes.dart';
import 'package:Method/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../providers/first_app_provider.dart';

class AppHeaderBar extends AppBar {
  AppHeaderBar({super.key, required this.nextPage, this.onClickNext});
  final String nextPage;
  void Function(Function cb)? onClickNext;

  @override
  State<AppHeaderBar> createState() => _AppHeaderBarState();
}

class _AppHeaderBarState extends State<AppHeaderBar> {
  final _saveDebouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(195, 195, 195, 1)))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: [
              AppHeaderButton(
                text: 'Главный экран',
                assetName: 'assets/icons/house-fill.svg',
                onClick: () {
                  bool canPop = Navigator.canPop(context);
                  if (canPop) {
                    Navigator.pushNamed(context, homeRoute);
                  }
                  final snackBar = SnackBar(
                    backgroundColor: Colors.grey,
                    content: const Text('Не забудьте сохранить изменения!'),
                    action: SnackBarAction(
                      label: 'Хорошо',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  );
                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  bool isChanged =
                      Provider.of<FirstAppProvider>(context, listen: false)
                          .isSmthChanged;
                  if (isChanged) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Сохранить',
                assetName: 'assets/icons/file-earmark.svg',
                bgColor: Provider.of<FirstAppProvider>(context, listen: false)
                        .isSmthChanged
                    ? Colors.green.shade100
                    : null,
                onClick: () {
                  _saveDebouncer.run(() {
                    Provider.of<FirstAppProvider>(context, listen: false)
                        .saveToFile()
                        .then((value) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green.shade400,
                        content: const Text('Изменения сохранены!'),
                        action: SnackBarAction(
                          label: 'Ок',
                          textColor: Colors.white,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      );
                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  });
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Сохранить как',
                assetName: 'assets/icons/save-as.svg',
                onClick: () {
                  Provider.of<FirstAppProvider>(context, listen: false)
                      .saveToFile(isNeedNewPath: true)
                      .then((value) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green.shade400,
                      content: const Text('Изменения сохранены!'),
                      action: SnackBarAction(
                        label: 'Ок',
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    );
                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Открыть сохранение',
                assetName: 'assets/icons/folder2-open.svg',
                onClick: () {
                  Provider.of<FirstAppProvider>(context, listen: false)
                      .importData()
                      .then((value) {
                    String? name = ModalRoute.of(context)?.settings.name;
                    if (name != null) {
                      Navigator.pushNamed(context, name);
                    }
                  });
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Отменить действие',
                assetName: 'assets/icons/arrow-90deg-left.svg',
                onClick: () {
                  Provider.of<FirstAppProvider>(context, listen: false)
                      .undoLastAction(context: context);
                  if (ModalRoute.of(context)?.settings.name ==
                      firstAppSecondRoute) {
                    Navigator.pushNamed(context, firstAppSecondRoute);
                  }
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(Colors.black),
                    value: context.watch<FirstAppProvider>().isSortedFos,
                    onChanged: (bool? value) {
                      setState(() {
                        context
                            .read<FirstAppProvider>()
                            .setSortedFos(value ?? false);
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Cгруппировать отдельно по классам K'),
                      TextSpan(text: '1', style: TextStyle(fontSize: 8)),
                      TextSpan(text: ' и K'),
                      TextSpan(text: '0', style: TextStyle(fontSize: 8)),
                    ], style: TextStyle(color: Colors.black, fontSize: 12)),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class AppHeaderButton extends StatelessWidget {
  AppHeaderButton(
      {super.key,
      this.bgColor,
      required this.text,
      this.onClick,
      required this.assetName});
  final String text;
  Color? bgColor;
  final String assetName;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: bgColor ?? const Color.fromARGB(255, 255, 255, 255),
          minimumSize: const Size(120.0, 36.0),
          side: BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0))),
      onPressed: onClick,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 36, 36, 36), fontSize: 16),
            )
          ]),
    );
  }
}
