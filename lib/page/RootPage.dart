import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/page/HomePage.dart';
import 'package:flutter_kpl_vip/page/MePage.dart';
import 'package:flutter_kpl_vip/page/RecommendPage.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

import 'MusicTheoryPage.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootPageState();
  }
}

class _RootPageState extends State<RootPage> {
  int _tabIndex = 0;
  var _pageList;
  var _tabImages;
  var _appBarTitles = ['首页', '推荐', '乐理', '我的'];
  final _pageController = PageController();
  
  @override
  void initState() {
    super.initState();
    initData();
  }
  
  void initData(){
    _pageList = [
      HomePage(),
      RecommendPage(),
      MusicTheoryPage(),
      MePage(),
    ];
    _tabImages = [
      [
        KPLAssetImage.generateImage("tabbar/icon_home_n"),
        KPLAssetImage.generateImage("tabbar/icon_home_s"),
      ],
      [
        KPLAssetImage.generateImage("tabbar/icon_recommend_n"),
        KPLAssetImage.generateImage("tabbar/icon_recommend_s"),
      ],
      [
        KPLAssetImage.generateImage("tabbar/icon_yueli_n"),
        KPLAssetImage.generateImage("tabbar/icon_yueli_s"),
      ],
      [
        KPLAssetImage.generateImage("tabbar/icon_me_n"),
        KPLAssetImage.generateImage("tabbar/icon_me_s"),
      ]
    ];
  }

  Image _getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  Widget _buildTabText(int curIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(_appBarTitles[curIndex]),
    );
  }

  DateTime  _lastTime;
  
  Future<bool> _isExit(){
    if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      KPLToast.show("再次点击退出应用");
      return Future.value(false);
    } 
    KPLToast.hide();
    return Future.value(true);
  }
  
  @override
  Widget build(BuildContext context) {
    Application.initScreenUtil(context);
    return WillPopScope(
      onWillPop: _isExit,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            for (int i = 0; i < _appBarTitles.length; i++)
              BottomNavigationBarItem(
                  icon: _getTabIcon(i),
                  title: _buildTabText(i)
              ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: KplColor.black,
          unselectedItemColor: KplColor.light_black,
          onTap: (index){
            _pageController.jumpToPage(index);
          },
        ),
        // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pageList,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        )
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}