import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class HeaderView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onClickMore;
  HeaderView(this.title, {this.subtitle = '查看更多', this.onClickMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAdaptation(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: screenAdaptationFontSize(18),
              color: Color(0xff353536),
              fontWeight: FontWeight.bold,
              fontFamily: 'PingFangSC-Medium',
            ),
          ),
          GestureDetector(
            onTap: onClickMore,
            child: Row(
              children: <Widget>[
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenAdaptationFontSize(12),
                    color: Color(0xff9B9B9D),
                    fontFamily: 'PingFangSC-Regular',
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
        ],
      ),
    );
  }
}
