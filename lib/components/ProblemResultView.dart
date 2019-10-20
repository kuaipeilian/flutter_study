import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/components/LevelLabel.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class ProblemResultView extends StatefulWidget {
  final List<ProblemModel> list;
  final Function onTapErrorOption;
  ProblemResultView({Key key, this.list = const [], this.onTapErrorOption}) : super(key: key);
  @override
  _ProblemResultViewState createState() {
    return _ProblemResultViewState();
  }
}

class _ProblemResultViewState extends State<ProblemResultView> {
  int score = 0;
  @override
  void initState() {
    super.initState();
    score = widget.list.where((item) => item.isCorrect).length;
  }

  String getLevelImgStr() {
    if (score < 6) {
      return 'level/level_1';
    }
    if (score < 9) {
      return 'level/level_2';
    }
      return 'level/level_3';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Gaps.vGap30,
              KPLAssetImage(
                getLevelImgStr(),
                width: 205,
              ),
              Gaps.vGap30,
              _generateDetailInfoItem(),
              Gaps.vGap20,
              _ResultView(
                list: widget.list,
                onTapErrorOption: widget.onTapErrorOption,
              ),
            ],
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
            child: KPLAssetImage('yl_bottom_bgc_answer'),
          ),
        ],
      ),
    );
  }

  Widget _generateDetailInfoItem() {
    return Column(
      children: <Widget>[
        Text('本次测试你的成绩是', style: TextStyles.text66R14),
        Text('$score分', style: TextStyles.titleAFM33),
        Gaps.vGap30,
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '错误题数：', style: TextStyles.text66R14),
            TextSpan(text: (widget.list.length - score).toString(), style: TextStyles.titleAEM17),
            TextSpan(text: '     点击  ', style: TextStyles.text66R14),
            WidgetSpan(
                child: KPLAssetImage(
              'radio_icon_e',
              width: 18,
            )),
            TextSpan(text: ' 查看正确答案', style: TextStyles.text66R14),
          ]),
        )
      ],
    );
  }
}

class _ResultView extends StatelessWidget {
  final List<ProblemModel> list;
  final Function onTapErrorOption;
  _ResultView({@required this.list, this.onTapErrorOption});
  final itemW = 60.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemW * 5.0,
      child: Wrap(
          spacing: 0, // 主轴(水平)方向间距
          runSpacing: 20.0, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.center, //沿主轴方向居中
          children: <Widget>[
            for (int i = 0; i < list.length; i++) _generateItem(i, list[i].isCorrect),
          ]),
    );
  }

  Widget _generateItem(int index, [bool isCorrect = true]) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!isCorrect && onTapErrorOption != null) {
          onTapErrorOption(index);
        }
      },
      child: Container(
      width: itemW,
      child: Row(
        children: <Widget>[
          KPLAssetImage(
            isCorrect ? 'radio_icon_s' : 'radio_icon_e',
            width: 25,
          ),
          Gaps.hGap10,
          Text(
            (index + 1).toString(),
            style: TextStyles.text35M20,
          )
        ],
      ),
    ),
    );
  }
}
