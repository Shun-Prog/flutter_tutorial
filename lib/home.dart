import 'package:flutter/material.dart';

import 'header.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(child: Text('Homgge')),
    );
  }
}
