import 'package:flutter/material.dart';
import 'home.dart';
import 'disney_land.dart';
import 'disney_sea.dart';

// main関数がrunApp関数を実行し、MyAppウィジェットを呼んでいる。
// ここはパッケージのimport宣言の次に来る部分でwidgetではない。アプリの始まりになる部分。
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Base(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Base extends StatefulWidget {
  @override
  _Base createState() => _Base();
}

class _Base extends State<Base> with SingleTickerProviderStateMixin {
  // ページ切り替え用のコントローラを定義
  PageController _pageController;

  // ページインデックス保存用
  int _screen = 0;

  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: const Text('HOME'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.cloud),
        title: const Text('TDL'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.cake),
        title: const Text('TDS'),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _screen, // 初期ページの指定 = HOME
    );
  }

  @override
  void dispose() {
    // コントローラ破棄
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _screen = index;
          });
        },
        children: <Widget>[
          Home(),
          DisneyLand(),
          DisneySea(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screen,
        onTap: (index) {
          setState(() {
            _screen = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        },
        items: myBottomNavBarItems(),
      ),
    );
  }
}
