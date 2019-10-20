import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/NewsItem.dart';
import 'package:flutter_kpl_vip/models/news_column_model.dart';
import 'package:flutter_kpl_vip/tool/common_refresh.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class ColumnListPage extends StatefulWidget {
  final int kinds;
  final String title;
  ColumnListPage({this.kinds, this.title});
  @override
  _ColumnListPageState createState() => _ColumnListPageState();
}

class _ColumnListPageState extends State<ColumnListPage> {
  int _count = 0;
  int _currentPage = 1;
  List<ArticleList> _list = [];
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadData();
  }

  _loadData({refresh = true}) async {
    if (refresh) {
      _currentPage = 1;
    } else {
      _currentPage++;
    }
    return NetUtils.post(Api.POST_ARTICLELIST, {
      'kinds': widget.kinds,
      'size': 10,
      'currentPage': _currentPage,
    }).then((res) {
      if (res.status) {
        _count = res.data['count'];
        List<ArticleList> list = getArticleModelList(res.data['rows']);
        if (refresh) {
          _list = list;
        } else {
          _list.addAll(list);
        }
        setState(() {});
        _controller.finishLoad(noMore: list.length < 10);
      } else {
        KPLToast.show(res.msg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? '媒体列表'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: EasyRefresh(
          onRefresh: () async {
            await _loadData();
          },
          onLoad: () async {
            await _loadData(refresh: false);
          },
          enableControlFinishLoad: true,
          header: createRefreshHeader(),
          footer: createRefreshFooter(),
          controller: _controller,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _generateNewsItem(context, index);
            },
            itemCount: _list.length,
          ),
        ),
      ),
    );
  }

  Widget _generateNewsItem(BuildContext context, int index) {
    return NewsItem(_list[index]);
  }
}
