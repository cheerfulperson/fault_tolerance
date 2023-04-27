import 'package:borovic/routes.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// you can add more fields that meet your needs

  const BaseAppBar({
    required this.title,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, homeRoute),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);
}
