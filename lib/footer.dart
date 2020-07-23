import 'package:flutter/material.dart';
import 'disney_sea.dart';

class Footer extends StatefulWidget {
  const Footer();
  @override
  _Footer createState() => _Footer();
}

class _Footer extends State {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      items: <BottomNavigationBarItem>[
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
      ],
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.blueAccent,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        //Navigator.pushNamed(context, "/sea");
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new DisneySea()));
        print('click!!');
      },
    ));
  }
}
