import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class GradientButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final String title;
  GradientButton({@required this.title, this.height = 48, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffFFDE42), Color(0xffFFA500)],
              begin: FractionalOffset(0.53, -0.33),
              end: FractionalOffset(0.59, 1.1)), //背景渐变
          borderRadius: BorderRadius.circular(24.0),
        ), //3像素圆角
        child: Center(
          child: Text(
            title,
            style: TextStyles.text35M18,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
