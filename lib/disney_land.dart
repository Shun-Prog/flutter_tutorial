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
      appBar: Header(),
      body: attractions(),
    );
  }
}
