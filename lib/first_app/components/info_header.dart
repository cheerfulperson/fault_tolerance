import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppInfoHeaderBar extends AppBar {
  AppInfoHeaderBar(
      {super.key, required this.backPage, this.onClickNext, this.onClickPrev});
  final String backPage;
  void Function(Function cb)? onClickNext;
  void Function(Function cb)? onClickPrev;

  @override
  State<AppInfoHeaderBar> createState() => _AppInfoHeaderBar();
}

class _AppInfoHeaderBar extends State<AppInfoHeaderBar> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppHeaderButton(
                text: 'Назад',
                assetName: 'assets/icons/arrow-left.svg',
                onClick: () {
                  bool canPop = Navigator.canPop(context);
                  if (canPop) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: '+',
                width: 24,
                assetName: 'assets/icons/search.svg',
                onClick: () {
                  widget.onClickNext!(() => {});
                },
              ),
              const SizedBox(
                width: 12,
              ),
              AppHeaderButton(
                text: '-',
                width: 24,
                assetName: 'assets/icons/search.svg',
                onClick: () {
                  widget.onClickPrev!(() => {});
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
