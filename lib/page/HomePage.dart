import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/HeaderView.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/components/ReceiveDialog.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/models/home_info_model.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/common_refresh.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  HomeInfoModel _homeInfo;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    return NetUtils.get(Api.GET_APP_INFO).then((res) {
      if (res.status) {
        _homeInfo = HomeInfoModel.fromJson(res.data);
        setState(() {});
      } else {
        KPLToast.show(res.msg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isShowGift = Application().baseInfo['isShowHomeGift'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: EasyRefresh.custom(
            onRefresh: () async {
              await _loadData();
            },
            header: createRefreshHeader(),
            slivers: _homeInfo != null
                ? <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate([
                      _generateBanner(),
                      if (isShowGift) _generateLinkImage()
                    ])),
                    _generateHeader(),
                    SliverGrid.count(
                      crossAxisSpacing: screenAdaptation(15),
                      mainAxisSpacing: screenAdaptation(20),
                      crossAxisCount: 2,
                      childAspectRatio: 1.14,
                      children: <Widget>[
                        for (int i = 0; i < _homeInfo.aboutUs.length; i++)
                          _generateItemView(_homeInfo.aboutUs[i]),
                      ],
                    )
                  ]
                : []),
      ),
    );
  }

  Widget _generateBanner() {
    return Container(
      height: screenAdaptation(160),
      child: Swiper(
        onTap: (index) {
          if (_homeInfo.topBanners[index]?.url != null) {
            Router.pushName(context, 'KPLWebViewPage',
                {'url': _homeInfo.topBanners[index].url});
          }
        },
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: _homeInfo.topBanners[index].cover,
                fit: BoxFit.cover,
              ));
        },
        itemCount: _homeInfo.topBanners.length,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: Color(0x5BFFFFFF),
                activeColor: Colors.white,
                size: 6,
                activeSize: 6,
                space: 5)),
      ),
    );
  }

  Widget _generateLinkImage() {
    return GestureDetector(
      onTap: () async {
        if (Application().userInfo.status != 0 &&
            Application().userInfo.status != -1) {
          Router.pushName(context, 'DownLoadPage');
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return ReceiveDialog();
              });
        }
      },
      child: Container(
        child: KPLAssetImage(
          'home_gift',
          width: null,
          height: null,
        ),
      ),
    );
  }

  Widget _generateHeader() {
    return SliverToBoxAdapter(
        child: HeaderView(
      '媒体报道',
      onClickMore: () {
        Router.pushName(context, 'MediaListPage');
      },
    ));
  }

  Widget _generateItemView(About_us data) {
    return GestureDetector(
      onTap: () {
        if (data?.link != null) {
          Router.pushName(context, 'KPLWebViewPage', {'url': data?.link});
        }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: data.cover,
                fit: BoxFit.cover,
                width: screenAdaptation(160),
                height: screenAdaptation(90),
              ),
            ),
            Gaps.vGap5,
            Text(
              data.title,
              style: TextStyle(
                fontSize: screenAdaptationFontSize(15),
                color: Color(0xff353536),
                fontFamily: 'PingFangSC-Regular',
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Gaps.vGap5,
            Text(data.subTitle,
                style: TextStyle(
                  fontSize: screenAdaptationFontSize(12),
                  color: Color(0xffC7C7C7),
                  fontFamily: 'PingFangSC-Regular',
                ),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
