import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
  @override
  bool get wantKeepAlive => true;

  void _commonItemClick(String title) {
    switch (title) {
      case '关于我们':
        String aboutUrl = Application().baseInfo['aboutUrl'] ??
            'http://news.kuaipeilian.com/m/about';
        Router.pushName(context, 'KPLWebViewPage', {'url': aboutUrl});
        break;
      case '联系客服':
        _callKeFu();
        break;
      case '检查更新':
        KPLToast.show('已经是最新版本了哦');
        // _checkVersion();
        break;
      default:
    }
  }

  void _callKeFu() async {
    String url = 'tel:' + '4000166123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _checkVersion() async {
    await Application().checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    var isGuestMode = Application().isGuestMode;
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            _generateTopItem(),
            Gaps.vGap30,
            _generateCommonItem('icon_gywm', '关于我们'),
            _generateCommonItem('icon_lxkf', '联系客服'),
            _generateCommonItem('icon_jcgx', '检查更新'),
            SizedBox(height: 150),
            if (!isGuestMode) _generateExitItem(),
          ],
        ),
      ),
    );
  }

  Widget _generateTopItem() {
    var mobile = Application()?.userInfo?.mobile ?? '';
    var isGuestMode = Application().isGuestMode;
    if (isGuestMode) {
      mobile = '登录';
    }
    return GestureDetector(
      onTap: () {
        if (isGuestMode) {
          Router.pushNamedAndRemoveUntil(context, name: 'LoginPage');
        }
      },
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: screenAdaptation(30),
            child: KPLAssetImage(
              'default_avatar',
              width: screenAdaptation(60),
              height: screenAdaptation(60),
            ),
          ),
          Gaps.hGap16,
          Text(
            mobile,
            style: TextStyle(
              fontSize: screenAdaptationFontSize(15),
              color: Color(0xff515151),
              fontWeight: FontWeight.bold,
              fontFamily: 'PingFangSC-Medium',
            ),
          )
        ],
      ),
    );
  }

  Widget _generateCommonItem(String icon, String title) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: KplColor.light_bgc,
        highlightColor: KplColor.light_bgc,
        onTap: () {
          _commonItemClick(title);
        },
        child: Container(
          height: screenAdaptation(50),
          child: Row(
            children: <Widget>[
              KPLAssetImage(
                icon,
                width: screenAdaptation(28),
                height: screenAdaptation(28),
              ),
              Gaps.hGap10,
              Text(
                title,
                style: TextStyle(
                  fontSize: screenAdaptationFontSize(18),
                  color: Color(0xff515151),
                  fontFamily: 'PingFangSC-Regular',
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(''),
                ),
              ),
              KPLAssetImage(
                'icon_right_arrow',
                width: screenAdaptation(8),
                height: screenAdaptation(8),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateExitItem() {
    return GestureDetector(
      onTap: () async {
        await Application().logout();
        Router.pushNamedAndRemoveUntil(context, name: 'LoginPage');
      },
      child: Container(
        height: screenAdaptation(48),
        decoration: BoxDecoration(
            color: KplColor.light_bgc,
            borderRadius: BorderRadius.circular(screenAdaptation(24))),
        child: Center(
          child: Text(
            '退出登录',
            style: TextStyle(
              fontSize: screenAdaptationFontSize(18),
              color: Color(0xff353536),
              fontFamily: 'PingFangSC-Regular',
            ),
          ),
        ),
      ),
    );
  }
}

class PackageInfo {}
