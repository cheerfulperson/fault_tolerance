import 'package:flutter/material.dart';

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
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          width: 1020,
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade500,
                    minimumSize: Size(180.0, 40.0)),
                onPressed: () {
                  bool canPop = Navigator.canPop(context);
                  if (canPop) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Назад'),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(180.0, 40.0)),
                onPressed: () {
                  if (widget.onClickNext != null) {
                    widget.onClickNext!(
                      () => {Navigator.pushNamed(context, widget.nextPage)},
                    );
                    return;
                  }
                  Navigator.pushNamed(context, widget.nextPage);
                },
                child: const Text('Далее'),
              )
            ],
          ),
        ));
  }
}