import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final title;
  final color;

  Header([this.title, this.color]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      title: Text(this.title),
      backgroundColor: this.color,
      actions: this.title != 'HOME'
          ? <Widget>[
              // ソートボタン
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {
                  sortModal(context);
                },
              ),
            ]
          : null,
    );
  }

  // ignore: missing_return
  Future<Widget> sortModal(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("並び替え"),
          children: <Widget>[
            // コンテンツ領域
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'normal'),
              child: Text("テーマポート順"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'short'),
              child: Text("待ち時間が短い順"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'long'),
              child: Text("待ち時間が長い順"),
            ),
          ],
        );
      },
    );
    print(result);
  }
}
