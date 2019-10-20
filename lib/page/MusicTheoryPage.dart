import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class MusicTheoryPage extends StatefulWidget {
  @override
  _MusicTheoryPageState createState() => _MusicTheoryPageState();
}

class _MusicTheoryPageState extends State<MusicTheoryPage>
    with AutomaticKeepAliveClientMixin<MusicTheoryPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('乐理测试'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _generateCard(1),
            _generateCard(2),
            _generateCard(3),
          ],
        ),
      ),
    );
  }

  Widget _generateCard(int index) {
    return GestureDetector(
      onTap: () {
        Router.pushName(context, 'MusicTestPage');
      },
      child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, left: 24, right: 24),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: KplColor.light_gray, width: 0.5),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('级别$index'),
          Gaps.vGap10,
          Text('10题          建议用时：${index * 5}分钟')
        ],
      ),
    ),
    );
  }
}
