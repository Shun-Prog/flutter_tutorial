import 'package:flutter/material.dart';
import 'header.dart';
import 'attraction.dart';

class DisneySea extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

class _SeaState extends State<DisneySea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        'TDS',
        Colors.blue[500],
      ),
      body: attractionsList('TDS'),
    );
  }
}
