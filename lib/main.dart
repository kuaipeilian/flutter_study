import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  bool isLogin = await Application().getLocalInfo();
  runApp(WLCVipApp(isLogin));
}

class WLCVipApp extends StatelessWidget {
  final bool isLogin;
  WLCVipApp(this.isLogin);
  static const Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders = <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  };


  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '技术调研',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(title: TextStyle(color: Color(0xff353536), fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'PingFangSC-Medium')),
            iconTheme: IconThemeData(color: Color(0xff333333)),
            elevation: 0,
            brightness: Brightness.light,
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: _defaultBuilders)
        ),
        routes: Router.allRouters(),
        home: Router.getInitPage(isLogin: isLogin),
      ),
    );
  }
}