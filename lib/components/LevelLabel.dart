import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/styles/textstyles.dart';

class LevelLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 42,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xffFFDE42), Color(0xffFFA500)],
            begin: FractionalOffset(0.53, -0.33),
            end: FractionalOffset(0.59, 1.1)), //背景渐变
        borderRadius: BorderRadius.only(topRight: Radius.circular(21), bottomRight: Radius.circular(21)),
      ),
      child: Center(child: Text('级别一', style: TextStyles.btnN18,),),
    );
  }
}