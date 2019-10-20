import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/page/AnswerDetailPage.dart';
import 'package:flutter_kpl_vip/page/ColumnListPage.dart';
import 'package:flutter_kpl_vip/page/DownLoadPage.dart';
import 'package:flutter_kpl_vip/page/HomePage.dart';
import 'package:flutter_kpl_vip/page/KPLWebViewPage.dart';
import 'package:flutter_kpl_vip/page/LoginPage.dart';
import 'package:flutter_kpl_vip/page/MePage.dart';
import 'package:flutter_kpl_vip/page/MediaListPage.dart';
import 'package:flutter_kpl_vip/page/MusicTestPage.dart';
import 'package:flutter_kpl_vip/page/MusicTheoryPage.dart';
import 'package:flutter_kpl_vip/page/RecommendPage.dart';
import 'package:flutter_kpl_vip/page/RootPage.dart';
import 'package:flutter_kpl_vip/page/TestResultPage.dart';

class Router {
  static Map<String, WidgetBuilder> allRouters() {
    return {
      "RootPage": (context) => RootPage(),
      "MePage": (context) => MePage(),
      "MusicTheoryPage": (context) => MusicTheoryPage(),
      "MusicTestPage": (context) => MusicTestPage(),
      "RecommendPage": (context) => RecommendPage(),
      "TestResultPage": (context) => TestResultPage(),
      "HomePage": (context) => HomePage(),
      "LoginPage": (context) => LoginPage(),
      "MediaListPage": (context) => MediaListPage(),
      "DownLoadPage": (context) => DownLoadPage(),
      "AnswerDetailPage": (context) {
        Map args = ModalRoute.of(context).settings.arguments;
        return AnswerDetailPage(
          data: args['data'],
          total: args['total'],
          index: args['index'],
        );
      },
      "ColumnListPage": (context) {
        Map args = ModalRoute.of(context).settings.arguments;
        return ColumnListPage(
          kinds: args['kinds'],
          title: args['title'],
        );
      },
      "KPLWebViewPage": (context) {
        Map args = ModalRoute.of(context).settings.arguments;
        return KPLWebViewPage(url: args['url']);
      },
    };
  }

  static void pushName(BuildContext context, String name,
      [Map<String, dynamic> params]) {
    if (params == null) {
      Navigator.pushNamed(context, name);
      return;
    }
    Navigator.pushNamed(context, name, arguments: params);
  }

  static void pushNamedAndRemoveUntil(BuildContext context,
      {String name = 'RootPage'}) {
    Navigator.pushNamedAndRemoveUntil(
        context, name, (Route<dynamic> route) => false);
  }
  
  static void pushReplacementNamed(BuildContext context,
      {String name = 'RootPage'}) {    
    Navigator.pushReplacementNamed(context, name);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  static bool pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static Widget getInitPage({isLogin = false}) {
    if (isLogin) {
      return RootPage();
    }
    return LoginPage();
  }
}
