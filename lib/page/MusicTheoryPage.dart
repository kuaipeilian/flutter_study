import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/TestCard.dart';
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
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TestCard(
                  level: 1,
                  isLock: false,
                  onTap: () {
                    Router.pushName(context, 'MusicTestPage');
                  }),
              Gaps.vGap20,
              TestCard(
                level: 2,
              ),
              Gaps.vGap20,
              TestCard(
                level: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
