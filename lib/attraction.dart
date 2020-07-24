import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';

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

Widget attractionsList(String parkType) {
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

        return ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: snap.data.length * 2,
            itemBuilder: (context, int i) {
              // 奇数の時は罫線を表示
              if (i.isOdd)
                return Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                );
              int idx = i ~/ 2;

              String oparating = snap.data[idx]['condition']['operating_1'];
              String status =
                  snap.data[idx]['condition']['facilityStatusMessage'];

              if (status != null) {
                oparating = status;
              }

              String time;
              if (oparating == '運営中') {
                time = snap.data[idx]['condition']['standbyTime'] ??= '';
              }

              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: snap.data[idx]['img_url'],
                  imageBuilder: (context, imageProvider) => Container(
                    width: 58.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(snap.data[idx]['name']),
                subtitle: Text(oparating),
                trailing: Text(
                  "${time != null ? '$time分' : ''}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              );
            });
      },
      future: parkType == 'TDS' ? fetchTdsAttraction() : fetchTdlAttraction(),
    ),
  );
}
