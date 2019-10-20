import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/MediaListItem.dart';
import 'package:flutter_kpl_vip/models/home_info_model.dart';
import 'package:flutter_kpl_vip/tool/common_refresh.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class MediaListPage extends StatefulWidget {
  MediaListPage();
  @override
  _MediaListPageState createState() => _MediaListPageState();
}

class _MediaListPageState extends State<MediaListPage> {
  List<About_us> _list = [];
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadData();
  }

  _loadData() async {
    return NetUtils.get(Api.GET_ABOUT_US_LIST).then((res) {
      if (res.status) {
        List<About_us> list = getAboutUsModelList(res.data);
        _list = list;
        setState(() {});
      } else {
        KPLToast.show(res.msg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('媒体列表'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: EasyRefresh(
          onRefresh: () async {
            await _loadData();
          },
          header: createRefreshHeader(),
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
    return MediaListItem(_list[index]);
  }
}
