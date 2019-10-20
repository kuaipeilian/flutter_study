
import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/styles/textstyles.dart';

class KPLPageView extends StatelessWidget {
  final int currentIndex;
  final int total;
  KPLPageView({this.currentIndex = 1, this.total = 10});

  @override
  Widget build(BuildContext context) {
    final isFirst = currentIndex == 1;
    final isEnd = currentIndex == total;
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          if (!isFirst) TextSpan(text: "1...", style: TextStyles.textC7M13),
          TextSpan(
            text: currentIndex.toString(),
            style: TextStyles.titleAEM17,
          ),
          if (!isEnd) TextSpan(text: "...$total", style: TextStyles.textC7M13),
        ]),
      ),
    );
  }
}