import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer();
  @override
  _Footer createState() => _Footer();
}

class _Footer extends State {
  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('HOME'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('TDL'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('TDS'),
      ),
    ]));
  }
}
