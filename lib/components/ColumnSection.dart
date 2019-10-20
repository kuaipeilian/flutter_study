import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/components/NewsItem.dart';
import 'package:flutter_kpl_vip/models/news_column_model.dart';

import 'HeaderView.dart';

class ColumnSection extends StatelessWidget {
  final NewsColumnModel model;
  final Function onClickMore;
  ColumnSection(this.model, {this.onClickMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          HeaderView(model.title, onClickMore: onClickMore,),
          ...model.articleList
              .sublist(0,
                  model.articleList.length > 3 ? 3 : model.articleList.length)
              .map((i) {
            return NewsItem(i);
          }).toList()
        ],
      ),
    );
  }
}
