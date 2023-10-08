import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/providers/second_app_providers.dart';
import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
            color: Color.fromRGBO(215, 215, 215, 1),
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(134, 134, 134, 1)))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                text: '',
                width: 16,
                assetName: 'assets/icons/info-circle.svg',
                onClick: () {
                  bool canPop = Navigator.canPop(context);
                  if (canPop) {
                    Navigator.pushNamed(context, secondAppInfoRoute);
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
                  Provider.of<SecondAppProvider>(context, listen: false)
                      .saveToFile();
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Сохранить как',
                assetName: 'assets/icons/download.svg',
                onClick: () {
                  Provider.of<SecondAppProvider>(context, listen: false)
                      .saveToFile(isNeedNewPath: true);
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Открыть сохранение',
                assetName: 'assets/icons/folder2-open.svg',
                onClick: () {
                  Provider.of<SecondAppProvider>(context, listen: false)
                      .importData()
                      .then((value) => Navigator.pushNamed(
                          context,
                          ModalRoute.of(context)?.settings.name ??
                              secondAppRoute));
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: 'Отменить последнее действие',
                assetName: 'assets/icons/arrow-90deg-left.svg',
                onClick: () {
                  Provider.of<SecondAppProvider>(context, listen: false)
                      .undoLast();
                  try {
                    Navigator.pushNamed(
                        context,
                        ModalRoute.of(context)?.settings.name ??
                            secondAppRoute);
                  } catch (e) {}
                },
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
      this.width = 120,
      required this.assetName});
  final String text;
  Color? bgColor;
  double width;
  final String assetName;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: bgColor ?? const Color.fromARGB(255, 255, 255, 255),
          minimumSize: Size(width, 36),
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
            if (text != '') ...[
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 36, 36, 36), fontSize: 16),
              )
            ]
          ]),
    );
  }
}
