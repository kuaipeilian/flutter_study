import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KPLTextField extends StatefulWidget {
  const KPLTextField(
      {Key key,
      @required this.controller,
      this.maxLength: 16,
      this.autoFocus: false,
      this.keyboardType: TextInputType.text,
      this.hintText: "",
      this.focusNode,
      this.isInputPwd: false,
      this.getVCode,
      this.telCode,
      this.config})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Function getVCode;
  final String telCode;
  final KeyboardActionsConfig config;

  @override
  _KPLTextField createState() => _KPLTextField();
}

class _KPLTextField extends State<KPLTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = true;
  bool _isClick = true;

  /// 倒计时秒数
  final int second = 60;

  /// 当前秒数
  int s;
  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
    if (widget.config != null && defaultTargetPlatform == TargetPlatform.iOS) {
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, widget.config);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          height: 48,
          padding: EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: KplColor.light_bgc),
          child: TextField(
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            obscureText: widget.isInputPwd ? !_isShowPwd : false,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            textInputAction: TextInputAction.done,
            keyboardType: widget.keyboardType,
            // 数字、手机号限制格式为0到9(白名单)， 密码限制不包含汉字（黑名单）
            inputFormatters: (widget.keyboardType == TextInputType.number ||
                    widget.keyboardType == TextInputType.phone)
                ? [WhitelistingTextInputFormatter(RegExp("[0-9]"))]
                : [BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]"))],
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 0),
                hintText: widget.hintText,
                counterText: "",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Offstage(
              offstage: _isShowDelete,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: KPLAssetImage(
                  "qyg_shop_icon_delete",
                  width: 18.0,
                  height: 18.0,
                ),
                onTap: () {
                  setState(() {
                    widget.controller.text = "";
                  });
                },
              ),
            ),
            if (widget.getVCode == null) Gaps.hGap10,
            Offstage(
              offstage: !widget.isInputPwd,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: KPLAssetImage(
                    _isShowPwd ? "qyg_shop_icon_display" : "qyg_shop_icon_hide",
                    width: 18.0,
                    height: 18.0,
                  ),
                  onTap: () {
                    setState(() {
                      _isShowPwd = !_isShowPwd;
                    });
                  },
                ),
              ),
            ),
            Offstage(
              offstage: widget.getVCode == null,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: FlatButton(
                  onPressed: _isClick
                      ? () async {
                          bool res = await widget.getVCode();
                          if (!res) {
                            return;
                          }
                          setState(() {
                            s = second;
                            _isClick = false;
                          });
                          _countdownTimer?.cancel();
                          _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                            s--;
                            if (s < 0) {
                              _isClick = true;
                              _countdownTimer?.cancel();
                            }
                            setState(() {
                            });
                          });
                        }
                      : null,
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 48,
                    width: 150,
                    padding: EdgeInsets.only(left: 26, right: 26),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffFFDE42), Color(0xffFFA500)],
                          begin: FractionalOffset(0, 0),
                          end: FractionalOffset(0, 1)), //背景渐变
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Center(
                      child:  Text(
                      _isClick ? "获取验证码" : "${s}s后获取",
                      style: TextStyles.btnN18,
                    ),
                    )
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
