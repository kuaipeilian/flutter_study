import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/api/local_data.dart';
import 'package:flutter_kpl_vip/components/ProblemView.dart';
import 'package:flutter_kpl_vip/models/problem_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class MusicTestPage extends StatefulWidget {
  @override
  _MusicTestPageState createState() => _MusicTestPageState();
}

class _MusicTestPageState extends State<MusicTestPage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  List<ProblemModel> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _list = await generateProblems();
    setState(() {});
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
      Router.pushReplacementNamed(context, name: 'TestResultPage');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: Container(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            for (int i = 0; i < _list.length; i++)
              ProblemView(
                  data: _list[i],
                  index: i,
                  onSelectPress: _onSelectPress,
                  onNextPress: _onNextPress,
                  onPrePress: _onPrePress),
          ],
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
      ),
    );
  }
}
