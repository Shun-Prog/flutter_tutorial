import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// main関数がrunApp関数を実行し、MyAppウィジェットを呼んでいる。
// ここはパッケージのimport宣言の次に来る部分でwidgetではない。アプリの始まりになる部分。
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  // buildメソッドを利用してreturnしているwidgetをビルド
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(), //statefullメソッドを返すクラスを呼び出す
    );
  }
}

// StatefullWidgetクラス
// Stateクラスをインスタンスとして生成し、widgetを呼び出す
// Stateクラスを返すだけのシンプルな構造
class RandomWords extends StatefulWidget {
  @override

  // クラスのインスタンス化にnewは省略できる？
  _RandomWordsState createState() => _RandomWordsState();

  /*
  アロー関数を利用しないハージョン
  _RandomWordsState createState() {
    return ( _RandomWordsState() );
  }
  */
}

// Stateクラス
class _RandomWordsState extends State<RandomWords> {
  // WordPair型でリストを宣言
  final _suggestions = <WordPair>[];
  // TextStyleクラスのコンストラクタ？
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override

  // buildメソッド
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]); //
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase, //パスカルケースの英単語
        style: _biggerFont, // フォントサイズ18で出力
      ),
    );
  }
}
