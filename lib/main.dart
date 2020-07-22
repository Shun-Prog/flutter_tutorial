import 'package:flutter/material.dart';

import 'header.dart';
import 'footer.dart';

import 'attraction.dart';

// main関数がrunApp関数を実行し、MyAppウィジェットを呼んでいる。
// ここはパッケージのimport宣言の次に来る部分でwidgetではない。アプリの始まりになる部分。
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // コンストラクタ
  // リダイレクティングコンストラクタで継承元のコンストラクタを呼び出し
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: Header(),
        body: attractions(),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}

Widget attractions() {
  return Center(
      child: FutureBuilder(
          builder: (context, snap) {
            // ロード中はスピナーを表示
            if (snap.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            // エラー時
            if (snap.hasError) {
              return Text("${snap.error}");
            }

            //print(snap.data[1]);

            return ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: snap.data.length * 2,
                itemBuilder: (context, int i) {
                  // 奇数の時は罫線を表示
                  if (i.isOdd) return Divider();
                  int idx = i ~/ 2;
                  return ListTile(
                    leading: Image(
                      // Imageウィジェット
                      image: NetworkImage(snap.data[idx]['img_url']), // 表示したい画像
                    ),
                    title: Text(snap.data[idx]['name']),
                    subtitle: Text(
                        snap.data[idx]['condition']['operating_1'] ??= ' '),
                  );
                });
          },
          future: fetchTdlAttraction()));
}
