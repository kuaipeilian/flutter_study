import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/api/local_data.dart';
import 'package:flutter_kpl_vip/components/ProblemResultView.dart';
import 'package:flutter_kpl_vip/components/ProblemView.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';

class MusicTestPage extends StatefulWidget {
  @override
  _MusicTestPageState createState() => _MusicTestPageState();
}

class _MusicTestPageState extends State<MusicTestPage> {
  List<ProblemModel> _list = [];
  bool isShowResult = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _list = await generateProblems();
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/yl_bgc.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('乐理测试:级别(一)'),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: isShowResult ? ProblemResultView(list: _list, onTapErrorOption: (index) {
            Router.pushName(context, 'AnswerDetailPage', {
              'data': _list[index],
              'index': index + 1,
              'total': _list.length,
            });
          },) : ProblemViews(list: _list, onDone: () {
            setState(() {
              isShowResult = true;
            });
          },)
        ),
      ),
    );
  }
}
