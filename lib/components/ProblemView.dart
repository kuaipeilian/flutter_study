import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/GradientButton.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/components/KPLPageView.dart';
import 'package:flutter_kpl_vip/components/LevelLabel.dart';
import 'package:flutter_kpl_vip/components/ProblemItemView.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class ProblemViews extends StatefulWidget {
  final list;
  final Function onDone;
  ProblemViews({Key key, this.list = const [], this.onDone}) : super(key: key);
  @override
  _ProblemViewsState createState() {
    return _ProblemViewsState();
  }
}

class _ProblemViewsState extends State<ProblemViews> {
  final _pageController = PageController();
  List _list = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(ProblemViews oldWidget) {
    super.didUpdateWidget(oldWidget);
    _list = List.from(widget.list);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _jumpToPage(int page) {
    _pageController.jumpToPage(page);
  }

  void _onSelectPress(int i, int select) {
    _list[select].selectOption = i;
    setState(() {});
  }

  void _onNextPress() {
    if (_list[_currentIndex].selectOption == -1) {
      KPLToast.show('请先回答本题');
      return;
    }
    if (_currentIndex < _list.length - 1) {
      _jumpToPage(++_currentIndex);
    } else {
      if (widget.onDone != null) {
        widget.onDone();
      }
    }
  }

  void _onPrePress() {
    if (_currentIndex > 0) {
      _jumpToPage(--_currentIndex);
    } else {
      KPLToast.show('这是第一题了');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              for (int i = 0; i < _list.length; i++)
                ProblemItemView(
                  data: _list[i],
                  index: i,
                  onSelectPress: _onSelectPress,
                ),
            ],
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
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
            child: IgnorePointer(
              child: KPLAssetImage('yl_bottom_bgc'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _generateActionView(),
          ),
          Positioned(
            bottom: 60 + bottomPadding,
            left: 0,
            right: 0,
            child: KPLPageView(
              currentIndex: _currentIndex + 1,
              total: _list.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateActionView() {
    final isFirst = _currentIndex + 1 == 1;
    final isEnd = _currentIndex + 1 == _list.length;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 140,
            child: GradientButton(
              onPressed: isFirst ? null : _onPrePress,
              title: '上一题',
              colors: isFirst
                  ? [Color(0xffC7C7C7), Color(0xffC7C7C7)]
                  : [Color(0xff6EC9FF), Color(0xff4F99FF)],
              height: 30,
              style: TextStyles.btnN17,
            ),
          ),
          Container(
            width: 140,
            child: GradientButton(
              onPressed: _onNextPress,
              title: isEnd ? '完成' : '下一题',
              colors: [Color(0xffFFDE42), Color(0xffFFA500)],
              height: 30,
              style: TextStyles.btnN17,
            ),
          ),
        ],
      ),
    );
  }
}


