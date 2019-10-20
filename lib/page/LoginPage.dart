import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/GradientButton.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/components/KPLTextField.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      nextFocus: false,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("关闭"),
          ),
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("关闭"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var isGuestMode = Application().isGuestMode;
    return Scaffold(
      body: Container(
        child: FormKeyboardActions(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _generateTopImg(),
                Gaps.vGap60,
                _generateInputContainer(),
                Gaps.vGap50,
                _generateSubmitBtn(),
                if (isGuestMode) Gaps.vGap10,
                if (isGuestMode)
                  GradientButton(
                    title: '游客登录',
                    onPressed: () async {
                      Router.pushNamedAndRemoveUntil(context);
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _generateTopImg() {
    return Container(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          KPLAssetImage('vip_logo', width: 90.0, height: 90.0),
          Gaps.vGap20,
          Text(
            'flutter 技术调研',
            style: TextStyles.text35M20,
          )
        ],
      ),
    );
  }

  Widget _generateSubmitBtn() {
    return GradientButton(
      title: '注册或登录',
      onPressed: () async {
        String mobile = _textController1.text;
        String ps = _textController2.text;
        if (mobile.length != 11 || ps.length != 6) {
          KPLToast.show('请输入正确的手机和密码');
          return;
        }
        var res2 = await NetUtils.post(
            Api.POST_LOGIN,
            {
              // 校验验证码
              "codeType": "register",
              "verifyCode": ps,
              // 公众字段
              "areaCode": "86",
              "mobile": mobile,

              "operateSource": 3,
              "deviceType": 3,
              "platform": 3,
              "storeType": 1,
            },
            contentType:
                ContentType.parse("application/x-www-form-urlencoded"));
        if (res2.status) {
          res2.data['mobile'] = mobile;
          bool isSaveSuccess = await Application().setLocalInfo(res2.data);
          if (isSaveSuccess) {
            Router.pushNamedAndRemoveUntil(context);
          } else {
            KPLToast.show('系统错误重新登录');
          }
        } else {
          KPLToast.show(res2.msg);
        }
      },
    );
  }

  Widget _generateInputContainer() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: <Widget>[
          _generateNameInput(),
          Gaps.vGap15,
          _generatePSInput(),
        ],
      ),
    );
  }

  Widget _generateNameInput() {
    return KPLTextField(
      focusNode: _nodeText1,
      controller: _textController1,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      hintText: "请输入手机号",
      config: _buildConfig(context),
    );
  }

  Widget _generatePSInput() {
    return KPLTextField(
      focusNode: _nodeText2,
      controller: _textController2,
      maxLength: 6,
      keyboardType: TextInputType.phone,
      hintText: "请输入验证码",
      config: _buildConfig(context),
      getVCode: () async {
        String mobile = _textController1.text;
        if (mobile == '' || mobile.length != 11) {
          KPLToast.show('请输入正确的手机号');
          return false;
        }
        var res = await NetUtils.post(Api.POST_SMS,
            {'mobile': mobile, 'codeType': "register", "areaCode": "86"});
        if (res.status) {
          return true;
        } else {
          KPLToast.show(res.msg);
          return false;
        }
      },
    );
  }
}
