import 'package:flutter/material.dart';

import 'components/header.dart';
import 'components/nav_bar.dart';

class DataInputTable extends StatefulWidget {
  const DataInputTable({super.key, required this.title});
  final String title;

  @override
  State<DataInputTable> createState() => _DataInputTableState();
}

class _DataInputTableState extends State<DataInputTable> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                      children: [],
                    ))),
                    const Spacer(),
          ],
        ),
      ),
    );
  }
}
