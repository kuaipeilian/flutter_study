import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class ProblemView extends StatelessWidget {
  final ProblemModel data;
  final int index;
  Function onSelectPress;
  Function onNextPress;
  Function onPrePress;
  ProblemView({this.data, this.index, this.onSelectPress, this.onNextPress, this.onPrePress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Gaps.vGap10,
          Container(
            width: screenAdaptation(40),
            height: screenAdaptation(40),
            decoration: BoxDecoration(
                border: Border.all(color: KplColor.light_gray, width: 2),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text((index + 1).toString()),
            ),
          ),
          Gaps.vGap10,
          Text(this.data.title ?? ''),
          Expanded(
            child: _generateOptionView(),
          ),
          _generateActionView(),
        ],
      ),
    );
  }

  Widget _generateOptionView() {
    const map = const ['A', 'B', 'C', 'D', 'E', 'F'];
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < this.data.options.length; i++)
              GestureDetector(
                onTap: () {
                  if (this.onSelectPress != null) {
                    this.onSelectPress(i, index);
                  }
                },
                child: Container(
                  color: i == data.selectOption ? KplColor.red : Colors.white,
                  margin: EdgeInsets.only(top: 20),
                  child: Text('${map[i]}. ${this.data.options[i] ?? ""}'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _generateActionView() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            onPressed: onPrePress,
            child: Text('上一题'),
          ),
          FlatButton(
            onPressed: onNextPress,
            child: Text('下一题'),
          ),
        ],
      ),
    );
  }
}
