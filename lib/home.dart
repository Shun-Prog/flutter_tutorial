import 'package:flutter/material.dart';

import 'header.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header('HOME', Colors.green),
        body: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text('東京ディズニーランド'),
                    subtitle: Text(
                      '8:00 - 20:00',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '最新の情報はオンライン予約購入サイトをご確認ください。なお、売り切れとなった券種が予告なく再販売となる可能性があります。',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.highlight_off,
                      color: Colors.red,
                    ),
                    title: Text('東京ディズニーシー'),
                    subtitle: Text(
                      '閉園中',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '最新の情報はオンライン予約購入サイトをご確認ください。なお、売り切れとなった券種が予告なく再販売となる可能性があります。',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
    /*Center(
          child: Column(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: const Text('東京ディズニーランド'),
                      subtitle: Text(
                        '8:00 - 20:00',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '最新の情報はオンライン予約購入サイトをご確認ください。なお、売り切れとなった券種が予告なく再販売となる可能性があります。',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ));*/
  }
}
