import 'package:flutter/material.dart';

import '../routes.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BaseAppBar({
    required this.title,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: HeaderBackButton(),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);
}

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? pathName = (ModalRoute.of(context)?.settings.name);
    return pathName != '/' && pathName != homeRoute
        ? IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, homeRoute),
            tooltip: 'На главную',
          )
        : const SizedBox.shrink();
  }
}
