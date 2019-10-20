import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class TestCard extends StatelessWidget {
  final Function onTap;
  final bool isLock;
  final int level;
  TestCard({this.onTap, this.isLock = true, this.level = 1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLock ? null : onTap,
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            KPLAssetImage('testCard/level_$level'),
            if (isLock)
              AspectRatio(
                aspectRatio: 345 / 160,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KplColor.transparency_6,
                  ),
                  width: double.infinity,
                ),
              ),
            if (isLock)
              Positioned(
                child: KPLAssetImage(
                  'testCard/level_lock',
                  width: 42,
                ),
              )
          ],
        ),
      ),
    );
  }
}
