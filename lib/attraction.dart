import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const BASE_URL = 'https://maihamatimez.com/api/v1/';

// Future(jsのpromiseみたいな)で包んでアトラクションオブジェクトを返す
Future fetchTdsAttraction() async {
  // APIをコールしてresponseに格納
  final response = await http.get('$BASE_URL/disneysea/attractions');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Attraction');
  }
}

Future fetchTdlAttraction() async {
  final response = await http.get('$BASE_URL/disneyland/attractions');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Attraction');
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

                  final oparating = snap.data[idx]['condition']['operating_1'];
                  String time;
                  if (oparating == '運営中') {
                    time = snap.data[idx]['condition']['standbyTime'] ??= '';
                  }

                  return ListTile(
                    leading: Image(
                      // Imageウィジェット
                      image: NetworkImage(snap.data[idx]['img_url']), // 表示したい画像
                    ),
                    title: Text(snap.data[idx]['name']),
                    subtitle:
                        Text("${oparating} ${time != null ? '${time}分' : ''}"),
                  );
                });
          },
          future: fetchTdlAttraction()));
}

Widget tdsAttractions() {
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

                  final oparating = snap.data[idx]['condition']['operating_1'];
                  String time;
                  if (oparating == '運営中') {
                    time = snap.data[idx]['condition']['standbyTime'] ??= '';
                  }

                  return ListTile(
                    leading: Image(
                      // Imageウィジェット
                      image: NetworkImage(snap.data[idx]['img_url']), // 表示したい画像
                    ),
                    title: Text(snap.data[idx]['name']),
                    subtitle:
                        Text("${oparating} ${time != null ? '${time}分' : ''}"),
                  );
                });
          },
          future: fetchTdsAttraction()));
}
