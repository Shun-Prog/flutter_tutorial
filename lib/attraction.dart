import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

const BASE_URL = 'https://maihamatimez.com/api/v1/';

// Future(jsのpromiseみたいな)で包んでアトラクションオブジェクトを返す
Future fetchTdsAttraction() async {
  // APIをコールしてresponseに格納
  final response = await http.get('$BASE_URL/disneysea/attractions');
  if (response.statusCode == 200) {
    print('fetch!!');
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Attraction');
  }
}

Future fetchTdlAttraction() async {
  final response = await http.get('$BASE_URL/disneyland/attractions');
  if (response.statusCode == 200) {
    print('fetch!!');
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Attraction');
  }
}

Widget attractionsList(Future _data, String _sortType) {
  return Center(
    child: FutureBuilder(
      future: _data,
      builder: (context, snap) {
        // 初回ロードはスピナーを表示
        if (snap.connectionState != ConnectionState.done &&
            snap.hasData != true) {
          return CircularProgressIndicator();
        }
        // エラー時
        if (snap.hasError) {
          return Text("${snap.error}");
        }

        /* リスト加工処理 */
        List<Map<String, dynamic>> test;
        test = List<Map<String, dynamic>>.from(snap.data);

        if (_sortType == 'normal') {
          test.sort((a, b) => a['id'] - b['id']);
          test.sort((a, b) => a['area'].compareTo(b['area']));
        }

        if (_sortType == 'short') {
          test.sort((a, b) {
            if (a['condition']['operating_1'] != '運営中' &&
                b['condition']['operating_1'] != '運営中') {
              return 0;
            } else if (a['condition']['operating_1'] != '運営中' &&
                b['condition']['operating_1'] == '運営中') {
              return 1;
            } else if (a['condition']['operating_1'] == '運営中' &&
                b['condition']['operating_1'] != '運営中') {
              return -1;
            } else {
              return int.parse(a['condition']['standbyTime']) -
                  int.parse(b['condition']['standbyTime']);
            }
          });
        }

        if (_sortType == 'long') {
          test.sort((a, b) {
            if (a['condition']['operating_1'] != '運営中' &&
                b['condition']['operating_1'] != '運営中') {
              return 0;
            } else if (a['condition']['operating_1'] != '運営中' &&
                b['condition']['operating_1'] == '運営中') {
              return 1;
            } else if (a['condition']['operating_1'] == '運営中' &&
                b['condition']['operating_1'] != '運営中') {
              return -1;
            } else {
              return int.parse(b['condition']['standbyTime']) -
                  int.parse(a['condition']['standbyTime']);
            }
          });
        }

        return ListView.builder(
            //padding: const EdgeInsets.all(5),
            itemCount: test.length * 2,
            itemBuilder: (context, int i) {
              // 奇数の時は罫線を表示
              if (i.isOdd)
                return Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                );
              int idx = i ~/ 2;

              String oparating = test[idx]['condition']['operating_1'];
              String status = test[idx]['condition']['facilityStatusMessage'];

              if (status != null) {
                oparating = status;
              }

              /// 運営中の場合のみスタンバイ時間を取得
              String startAt = "";
              String endAt = "";
              String time = "";
              if (oparating == '運営中') {
                time = test[idx]['condition']['standbyTime'];
                var format = new DateFormat("Hm");

                startAt = format.format(
                    DateTime.parse(test[idx]['condition']['startAt'])
                        .toLocal());
                endAt = format.format(
                    DateTime.parse(test[idx]['condition']['endAt']).toLocal());
              }

              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: test[idx]['img_url'],
                  imageBuilder: (context, imageProvider) => Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 35.0),
                        child: Text(
                          '©︎Disney',
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                    width: 58.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(test[idx]['name']),
                subtitle: Text(oparating + ' ' + startAt + ' - ' + endAt),
                trailing: Text(
                  "${time != "" ? '$time分' : ''}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              );
            });
      },
    ),
  );
}
