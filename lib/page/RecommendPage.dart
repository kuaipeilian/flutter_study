import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/ColumnSection.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/news_column_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/common_refresh.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin<RecommendPage> {
  @override
  bool get wantKeepAlive => true;

  final titleList = [
    {'type': 46, 'title': '钢琴陪练'},
    {'type': 47, 'title': '钢琴故事'},
    {'type': 48, 'title': '钢琴入门'},
    {'type': 49, 'title': '钢琴进阶'},
    {'type': 50, 'title': '钢琴科普'},
    {'type': 51, 'title': '钢琴考级'},
    {'type': 52, 'title': '钢琴大师'},
    {'type': 53, 'title': '钢琴交流'},
    {'type': 54, 'title': '钢琴曲'},
    {'type': 55, 'title': '儿童教育'},
  ];

  List<NewsColumnModel> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    return NetUtils.get(Api.GET_GROUPLIST).then((res) {
      if (res.status) {
        List<NewsColumnModel> list = getNewsColumnModelList(res.data);
        _list = list
            .where((NewsColumnModel item) => item.type != 57 && item.type != 56)
            .toList();
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
        title: Text('推荐'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: EasyRefresh.custom(
          onRefresh: () async {
            await _loadData();
          },
          header: createRefreshHeader(),
          slivers: <Widget>[
            _generateTopView(),
            _generateColumnList(),
          ],
        ),
      ),
    );
  }

  Widget _generateTopView() {
    return SliverGrid.count(
      crossAxisSpacing: 15,
      mainAxisSpacing: 20,
      crossAxisCount: 5,
      childAspectRatio: 0.6875,
      children: titleList.asMap().keys.map((i) {
        return _generateColumnView('recommend/column_icon_1$i',
            titleList[i]['title'], titleList[i]['type']);
      }).toList(),
    );
  }

  Widget _generateColumnView(String icon, String title, int type) {
    return GestureDetector(
      onTap: () {
        Router.pushName(
            context, 'ColumnListPage', {'kinds': type, 'title': title});
      },
      child: Container(
        child: Column(
          children: <Widget>[
            KPLAssetImage(
              icon,
              width: screenAdaptation(44),
            ),
            SizedBox(
              height: screenAdaptation(4),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: screenAdaptationFontSize(11),
                color: Color(0xff666666),
                fontFamily: 'PingFangSC-Regular',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _generateColumnList() {
    return SliverList(
        delegate: SliverChildListDelegate(_list.map((i) {
      return ColumnSection(
        i,
        onClickMore: () {
          Router.pushName(
              context, 'ColumnListPage', {'kinds': i.type, 'title': i.title});
        },
      );
    }).toList()));
  }
}
