import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/GradientButton.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class DownLoadPage extends StatefulWidget {
  @override
  _DownLoadPageState createState() => _DownLoadPageState();
}

class _DownLoadPageState extends State<DownLoadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap40,
            KPLAssetImage(
              'recived_success',
              width: 93,
              height: 62,
            ),
            Gaps.vGap40,
            Text(
              '您已领取成功',
              style: TextStyles.text66R15,
            ),
            Text(
              '点击下载APP，去上课',
              style: TextStyles.text35R15,
            ),
            Gaps.vGap50,
            GradientButton(
              title: '立即下载',
              onPressed: () async {
                var url = '';
                if (Platform.isIOS) {
                  url =
                      'https://itunes.apple.com/cn/app/id1390996130?l=zh&ls=1&mt=8';
                } else if (Platform.isAndroid) {
                  url = 'http://www.kuaipeilian.com/m/app_distribution?type=1';
                }
                if (url.isNotEmpty && await canLaunch(url)) {
                  await launch(url ?? '');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
