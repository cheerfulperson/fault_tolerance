import 'package:Method/providers/first_app_provider.dart';
import 'package:Method/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FirstAppNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isAllDisabled =
        context.watch<FirstAppProvider>().deviceParams.length == 0;

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
                      text: 'Исходные данные',
                      assetName: 'assets/icons/file-earmark-bar-graph.svg',
                      onClick: () {
                        Navigator.pushNamed(context, firstAppRoute);
                      },
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppRoute,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NavBarButton(
                      text: 'Фрагмент результатов ОЭ',
                      assetName: 'assets/icons/file-earmark-spreadsheet.svg',
                      onClick: () {
                        Navigator.pushNamed(context, firstAppSecondRoute);
                      },
                      disabled: isAllDisabled,
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppSecondRoute,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NavBarButton(
                      text: 'Определение центров',
                      assetName: 'assets/icons/chevron-bar-contract.svg',
                      onClick: () {
                        Navigator.pushNamed(
                            context, firstAppCenteredValuesRoute);
                      },
                      disabled: isAllDisabled,
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppCenteredValuesRoute,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NavBarButton(
                      text: 'Преобразование в код',
                      assetName: 'assets/icons/code-slash.svg',
                      onClick: () {
                        Navigator.pushNamed(
                            context, firstAppTransformationRoute);
                      },
                      disabled: isAllDisabled,
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppTransformationRoute,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NavBarButton(
                      text: 'Частная информация',
                      assetName: 'assets/icons/file-earmark-medical.svg',
                      onClick: () {
                        Navigator.pushNamed(
                            context, firstAppPrivateInformationPage);
                      },
                      disabled: isAllDisabled,
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppPrivateInformationPage,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    NavBarButton(
                      text: 'Проверка качества',
                      assetName: 'assets/icons/box-seam.svg',
                      onClick: () {
                        Navigator.pushNamed(context, firstAppResultsPage);
                      },
                      disabled: isAllDisabled,
                      active: ModalRoute.of(context)?.settings.name ==
                          firstAppResultsPage,
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
      this.disabled = false,
      required this.assetName,
      required this.active});
  final String text;
  final String assetName;
  final bool active;
  final bool disabled;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled
            ? Color.fromARGB(255, 126, 126, 126)
            : active
                ? Color.fromARGB(255, 230, 230, 230)
                : const Color.fromARGB(255, 255, 255, 255),
        minimumSize: const Size(120.0, 48.0),
        maximumSize: const Size(1000.0, 48.0),
      ),
      onPressed: () {
        if (!disabled) {
          onClick!();
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.red.shade500,
            content: const Text(
                'Вы ввели недостаточно данных, чтобы перейти на эту страницу!'),
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
        }
      },
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
