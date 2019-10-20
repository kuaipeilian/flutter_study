import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/models/user_info_model.dart';
import 'package:flutter_kpl_vip/tool/preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class Application {
  static Application _instance = Application._();
  EventBus eventBus = EventBus();
  // 是否是生产模式
  bool isProduction = const bool.fromEnvironment("dart.vm.product");
  // 接口环境
  String baseUrlEnv = 'pro';
  // 本地信息
  UserInfoModel userInfo;
  // 基本信息
  Map<String, dynamic> baseInfo;

  String get baseUrl {
    return baseUrlEnv == 'dev' ? Api.BASE_URL_DEV : Api.BASE_URL_PRO;
  }

  String get webviewBaseUrl {
    return baseUrlEnv == 'dev' ? Api.BASE_Web_DEV : Api.BASE_Web_PRO;
  }

  bool get isGuestMode {
    return (!(baseInfo['isShowHomeGift'] ?? false)) && (userInfo.accountId == null);
  }

  factory Application() {
    return _instance;
  }
  Application._();

  Future<bool> logout() async {
    return await PreferencesStorage.remove(PreferencesKey.VIP_INFO);
  }

  Future<bool> setLocalInfo(Map<String, dynamic> json) async {
    userInfo = UserInfoModel.fromJson(json);
    return await PreferencesStorage.saveMap(PreferencesKey.VIP_INFO, json);
  }

  Future<bool> getBaseInfo() async {
    // 拉取远程basinfo 信息
    var res = await NetUtils.post(Api.POST_BASEINFO, {
      'version': '1.0.0',
    });
    Map<String, dynamic> remoteInfo = {};
    if (res.status) {
      remoteInfo = res.data;
    }

    var localBaseinfo = await rootBundle.loadString('assets/data/baseInfo.json');

    baseInfo = json.decode(localBaseinfo);
    baseInfo.addAll(remoteInfo);
    return true;
  }

  Future<bool> getLocalInfo() async {
    var resList = await Future.wait([PreferencesStorage.getMap(PreferencesKey.VIP_INFO), getBaseInfo()]);
    Map<String, dynamic> info = resList[0];


    if (info != null && info.isNotEmpty) {
      userInfo = UserInfoModel.fromJson(info);
      if (userInfo.accountId.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      userInfo = UserInfoModel(token: '', mobile: '');
      return false;
    }
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  }

  Future<bool> checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    NetUtils.post(Api.POST_APP_STROE_URL, {}).then((res) {});
    return true;
  }

  // 初始化屏幕适配
  static void initScreenUtil(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }
}

double screenAdaptation(double value) {
  return ScreenUtil.getInstance().setWidth(value * 2);
}
double screenAdaptationFontSize(double value, {allowFontScaling: false}) {
  return ScreenUtil(allowFontScaling: allowFontScaling).setSp(value * 2) ;
}