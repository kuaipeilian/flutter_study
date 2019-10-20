import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/api/local_data.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/components/KPLPageView.dart';
import 'package:flutter_kpl_vip/components/LevelLabel.dart';
import 'package:flutter_kpl_vip/components/ProblemItemView.dart';
import 'package:flutter_kpl_vip/components/ProblemResultView.dart';
import 'package:flutter_kpl_vip/components/ProblemView.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class AnswerDetailPage extends StatefulWidget {
  final ProblemModel data;
  final int total;
  final int index;
  AnswerDetailPage({@required this.data, this.total = 10, this.index = 1});
  @override
  _AnswerDetailPageState createState() => _AnswerDetailPageState();
}

class _AnswerDetailPageState extends State<AnswerDetailPage> {
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
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ProblemItemView(
                data: widget.data,
              ),
              Positioned(
                top: 27,
                left: 0,
                child: LevelLabel(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: KPLAssetImage('yl_bottom_bgc'),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: KPLPageView(
                  currentIndex: widget.index,
                  total: widget.total,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
