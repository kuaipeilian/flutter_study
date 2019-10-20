import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class ProblemItemView extends StatelessWidget {
  final ProblemModel data;
  final int index;
  final Function onSelectPress;
  final map = const ['A', 'B', 'C', 'D', 'E', 'F'];
  ProblemItemView({this.data, this.index, this.onSelectPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenAdaptation(90)),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenAdaptation(284),
              minHeight: screenAdaptation(48)
            ),
            child: Text(
              this.data?.title ?? '',
              style: TextStyles.titleAEM17,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenAdaptation(10)),
          Expanded(
            child: _generateOptionView(),
          ),
        ],
      ),
    );
  }

  Widget _generateOptionView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < this.data.options.length; i++)
              _generateOptionItem(i),
          ],
        ),
      ),
    );
  }

  Widget _generateOptionItem(int i) {
    final isSelect = i == data.selectOption;
    final Options option = this.data.options[i];
    final bool isTextOption = option.imgStr.isEmpty;
    final isAnswer = this.onSelectPress == null;
    return GestureDetector(
      onTap: () {
        if (!isAnswer) {
          this.onSelectPress(i, index);
        }
      },
      child: Container(
        width: double.infinity,
        height: 64,
        color: isSelect ? KplColor.light_yellow : Colors.white,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            KPLAssetImage(
              isSelect
                  ? 'radio_icon_s'
                  : (isAnswer ? 'radio_icon_e' : 'radio_icon_n'),
              width: 25,
            ),
            Gaps.hGap30,
            isTextOption
                ? Text('${map[i]}. ${this.data.options[i].detail ?? ""}')
                : KPLAssetImage(
                    'answer/${option.imgStr}',
                    extName: '',
                    height: 64,
                  ),
          ],
        ),
      ),
    );
  }
}
