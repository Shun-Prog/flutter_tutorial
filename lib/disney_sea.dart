import 'package:flutter/material.dart';
import 'attraction.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class DisneySea extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

class _SeaState extends State<DisneySea> {
  Future<dynamic> _data;
  String _sortType;

  @override
  void initState() {
    super.initState();
    _data = fetchTdsAttraction();
    _sortType = 'normal';
  }

  Future _sort(String type) async {
    _sortType = type;
    print(_sortType);
    //_data = fetchTdlAttraction();
    setState(() {});
  }

  Future reload() {
    _data = fetchTdsAttraction();
    setState(() {});
    return _data;
  }

  // ignore: missing_return
  Future<Widget> sortModal(BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          children: <Widget>[
            // コンテンツ領域
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'normal'),
              child: ListTile(
                selected: _sortType == 'normal' ? true : false,
                leading: Icon(Icons.sort_by_alpha),
                title: Text("テーマポート順"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'short'),
              child: ListTile(
                selected: _sortType == 'short' ? true : false,
                leading: Icon(Icons.trending_up),
                title: Text("待ち時間が短い順"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'long'),
              child: ListTile(
                selected: _sortType == 'long' ? true : false,
                leading: Icon(Icons.trending_down),
                title: Text("待ち時間が長い順"),
              ),
            ),
          ],
        );
      },
    );
    _sort(result ??= _sortType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('TDS'),
        actions: <Widget>[
          // ソートボタン
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              sortModal(context);
            },
          ),
        ],
      ),
      body: CustomRefreshIndicator(
        child: attractionsList(_data, _sortType),
        // リフレッシュ用処理
        onRefresh: () => reload(),
        builder: (BuildContext context, Widget child,
            IndicatorController controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  if (!controller.isIdle)
                    Positioned(
                      top: 35.0 * controller.value,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          value: !controller.isLoading
                              ? controller.value.clamp(0.0, 1.0)
                              : null,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(0, 100.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
