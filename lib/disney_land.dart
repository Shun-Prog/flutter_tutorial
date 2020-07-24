import 'package:flutter/material.dart';
import 'header.dart';
import 'attraction.dart';

class DisneyLand extends StatefulWidget {
  @override
  _LandState createState() => _LandState();
}

class _LandState extends State<DisneyLand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        'TDL',
        Colors.pink[200],
      ),
      body: attractionsList('TDL'),
    );
  }
}
