import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class KPLSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const KPLSeparator({this.height = 0.5, this.color = KplColor.light_gray});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = MediaQuery.of(context).size.width;
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}