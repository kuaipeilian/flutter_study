import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/models/home_info_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';

class MediaListItem extends StatelessWidget {
  final About_us model;
  MediaListItem(this.model);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model?.link != null) {
          Router.pushName(context, 'KPLWebViewPage', {'url': model?.link});
        }
      },
      child: _generateContainer(),
    );
  }

  Widget _generateContainer() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: model.cover,
              width: 115,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          Gaps.hGap12,
          Expanded(
            flex: 1,
            child: Container(
              height: 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(model.title,
                            style: TextStyles.text35R15,
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
                              child: Text(model?.scores ?? '',
                                  style: TextStyles.title9BR10,
                                  overflow: TextOverflow.ellipsis),
                            )
                          ],
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        model?.publish ?? '',
                        style: TextStyles.title9BR11,
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
