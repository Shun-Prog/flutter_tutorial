import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final title;
  final color;

  Header([this.title, this.color]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      title: Text(this.title),
      backgroundColor: this.color,
    );
  }
}
