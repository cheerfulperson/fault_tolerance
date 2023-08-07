import 'dart:io';

import 'package:Method/routes.dart';
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
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Сохранить',
                assetName: 'assets/icons/file-earmark.svg',
                onClick: () {
                  // TODO move it to file class
                  FilePicker.platform.pickFiles(
                    allowedExtensions: ['json'],
                    type: FileType.custom,
                  ).then((result) {
                    if (result?.files.single.path != null) {
                      File file = File(result?.files.single.path ?? '');
                      print(result?.files.single.path);
                    } else {
                      // User canceled the picker
                    }
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
                        // TODO move it to file class
                  FilePicker.platform.pickFiles(
                    allowedExtensions: ['json'],
                    type: FileType.custom,
                  ).then((result) {
                    if (result?.files.single.path != null) {
                      File file = File(result?.files.single.path ?? '');
                      print(result?.files.single.path);
                    } else {
                      // User canceled the picker
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
      {super.key, required this.text, this.onClick, required this.assetName});
  final String text;
  final String assetName;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
