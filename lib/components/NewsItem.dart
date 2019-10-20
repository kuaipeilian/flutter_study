import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/news_column_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/date_util.dart';

class NewsItem extends StatelessWidget {
  final ArticleList model;
  NewsItem(this.model);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String baseUrl = Application().webviewBaseUrl;
        Router.pushName(context, 'KPLWebViewPage',
            {'url': '$baseUrl/m/list/${model.kinds}/fdetail/${model.id}'});
      },
      child: _generateContainer(),
    );
  }

  Widget _generateContainer() {
    var timeStr = '';
    if (model.updatedAt.isNotEmpty) {
      timeStr = DateUtil.formatDateStr(model.updatedAt, format: 'yyyy/MM/dd');
    }
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: model.cover,
              width: screenAdaptation(115),
              height: screenAdaptation(65),
              fit: BoxFit.cover,
            ),
          ),
          Gaps.hGap12,
          Expanded(
            flex: 1,
            child: Container(
              height: screenAdaptation(65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(model.title,
                            style: TextStyle(
                              fontSize: screenAdaptationFontSize(15),
                              color: Color(0xff353536),
                              fontFamily: 'PingFangSC-Regular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: KplColor.light_bgc,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(model.keywords,
                                  style: TextStyle(
                                    fontSize: screenAdaptationFontSize(10),
                                    color: Color(0xff9B9B9D),
                                    fontFamily: 'PingFangSC-Regular',
                                  ),
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: screenAdaptationFontSize(11),
                          color: Color(0xff9B9B9D),
                          fontFamily: 'PingFangSC-Regular',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
