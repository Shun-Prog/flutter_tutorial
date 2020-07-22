import 'package:http/http.dart' as http;
import 'dart:convert';

const BASE_URL = 'https://maihamatimez.com/api/v1/';

class Attraction {
  final List attraction;

  // コンストラクタ
  Attraction(this.attraction);
}

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
