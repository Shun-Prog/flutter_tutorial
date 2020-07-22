import 'package:http/http.dart' as http;
import 'dart:convert';

class Attraction {
  final List attraction;

  // コンストラクタ
  Attraction(this.attraction);
}

// Future(jsのpromiseみたいな)で包んでアトラクションオブジェクトを返す
Future fetchAttraction() async {
  // APIをコールしてresponseに格納
  final response =
      await http.get('https://maihamatimez.com/api/v1/disneysea/attractions');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Attraction');
  }
}
