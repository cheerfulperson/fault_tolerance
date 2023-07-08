import 'package:Method/providers/first_app_provider.dart';
import 'package:flutter/material.dart';

class DisplayParam extends StatelessWidget {
  DisplayParam(
      {super.key, required this.param, this.withoutUnit = false, this.size = 18});
  DeviceParams param;
  bool? withoutUnit;
  double? size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(
              text: param.shortName,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: param.shortNameDescription,
              style: TextStyle(
                  fontSize: (size ?? 18) / 1.8,
                  fontFamily: 'Consolas',
                  fontStyle: FontStyle.italic),
            ),
            TextSpan(
                text: withoutUnit == true || param.unit.isEmpty
                    ? ''
                    : ', ${param.unit}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ))
          ],
          style: TextStyle(
              fontSize: size,
              color: Colors.black,
              fontFamily: 'Consolas',
              fontStyle: FontStyle.italic)),
    );
  }
}
