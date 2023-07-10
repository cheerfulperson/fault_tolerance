import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SecondAppNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        constraints: BoxConstraints(maxHeight: 64),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0, color: Color.fromRGBO(195, 195, 195, 1)))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 60,
                child: Row(
                  children: [
                    NavBarButton(
                      text: '\t\tВвод\nданных',
                      // text: '1',
                      assetName: 'assets/icons/file-earmark-bar-graph.svg',
                      onClick: () {
                        Navigator.pushNamed(context, secondAppRoute);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          secondAppRoute,
                    ),
                    NavBarSpacer(index: 1),
                    NavBarButton(
                      text:
                          '\tЗависимость параметра P\nот имитационного фактора',
                      // text: '2',
                      assetName: 'assets/icons/file-earmark-spreadsheet.svg',
                      onClick: () {
                        Navigator.pushNamed(context, secondAppDatafields);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          secondAppDatafields,
                    ),
                    NavBarSpacer(index: 2),
                    NavBarButton(
                      text:
                          'Ускоренные испытания на \n\t\t\tдлительную наработку ',
                      // text: '3',
                      assetName: 'assets/icons/file-earmark-spreadsheet.svg',

                      onClick: () {
                        Navigator.pushNamed(
                            context, secondAppDatafieldsThreePage);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          secondAppDatafieldsThreePage,
                    ),
                    NavBarSpacer(index: 3),
                    NavBarButton(
                      text:
                          'Зависимость параметра P\n\t\t\t\t\t\t\t\t\t\tот наработки t',
                      // text: '4',
                      assetName: 'assets/icons/file-earmark-spreadsheet.svg',

                      onClick: () {
                        Navigator.pushNamed(
                            context, secondAppDatafieldsFourPage);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          secondAppDatafieldsFourPage,
                    ),
                    NavBarSpacer(index: 4),
                    NavBarButton(
                      text: '\tИндивидуальное \nпрогнозирование',
                      // text: '5',
                      assetName: 'assets/icons/file-earmark-spreadsheet.svg',

                      onClick: () {
                        Navigator.pushNamed(
                            context, secondAppDatafieldsFivePage);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          secondAppDatafieldsFivePage,
                    ),
                  ],
                )),
          ],
        ));
  }
}

class NavBarButton extends StatelessWidget {
  NavBarButton(
      {super.key,
      required this.text,
      this.onClick,
      required this.assetName,
      required this.active});
  final String text;
  final String assetName;
  final bool active;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active
            ? Color.fromARGB(255, 214, 214, 214)
            : const Color.fromARGB(255, 255, 255, 255),
        minimumSize: const Size(120.0, 48.0),
        maximumSize: const Size(1000.0, 48.0),
      ),
      onPressed: onClick,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName,
                colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(255, 36, 36, 36), fontSize: 14),
            )
          ]),
    );
  }
}

class NavBarSpacer extends StatelessWidget {
  const NavBarSpacer({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 32,
            margin: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromRGBO(0, 0, 0, 1)))),
            child: Text(
              index.toString(),
              style: const TextStyle(
                  color: Color.fromARGB(255, 36, 36, 36), fontSize: 16),
            ),
          )
        ]);
  }
}
