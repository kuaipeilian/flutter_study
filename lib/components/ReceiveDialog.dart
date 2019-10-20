import 'package:flutter/material.dart';
import 'package:flutter_kpl_vip/api/api.dart';
import 'package:flutter_kpl_vip/api/new_utils.dart';
import 'package:flutter_kpl_vip/components/GradientButton.dart';
import 'package:flutter_kpl_vip/components/KPLAssetImage.dart';
import 'package:flutter_kpl_vip/config/application.dart';
import 'package:flutter_kpl_vip/routers/router.dart';
import 'package:flutter_kpl_vip/styles/resources.dart';
import 'package:flutter_kpl_vip/tool/toast.dart';

class ReceiveDialog extends StatefulWidget {
  @override
  _ReceiveDialogState createState() => _ReceiveDialogState();
}

class _ReceiveDialogState extends State<ReceiveDialog> {
  final _pageController = PageController();
  int _currentIndex = 0;
  String _selectKey = '';
  Map<String, String> dates = {};

  @override
  void initState() {
    super.initState();
    _loadReceiveResults();
  }

  void _loadReceiveResults() {
    NetUtils.get(Api.GET_RECEIVE_RESULTS, {
      'account_id': Application().userInfo.accountId,
    }).then((res) {
      if (res.status) {
        dates = Map.castFrom(res.content);
        setState(() {});
      } else {
        KPLToast.show(res.msg);
      }
    });
  }

  _appointmentClass() {
    return NetUtils.post(Api.POST_APP_APPOINTMENT, {
      'account_id': Application().userInfo.accountId,
      'start_date': _selectKey
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _jumpToPage(int page) {
    // _pageController.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogTheme: DialogTheme(
            contentTextStyle: TextStyle(decoration: TextDecoration.none),
            titleTextStyle: TextStyle(decoration: TextDecoration.none)),
      ),
      child: Container(
          padding: EdgeInsets.only(left: 33, right: 33, bottom: 70),
          child: Center(
            child: Container(
              height: 420,
              child: Stack(
                children: <Widget>[
                  PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      _generateFirstPage(),
                      _generateSecondPage(),
                      _generateThirdPage(),
                    ],
                    physics: NeverScrollableScrollPhysics(), // 禁止滑动
                  ),
                  _pageHeader()
                ],
              ),
            ),
          )),
    );
  }

  Widget _pageHeader() {
    return Positioned(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5),
                      color: _currentIndex == i
                          ? Color(0xffFFB310)
                          : Color(0xffE5E5EA),
                    ),
                    width: _currentIndex == i ? 14 : 5,
                    height: 5,
                  )
              ],
            ),
            GestureDetector(
              onTap: () {
                Router.pop(context);
              },
              child: KPLAssetImage(
                'icon_grey_closed',
                width: 17,
                height: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pageLayout({@required child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: child,
    );
  }

  Widget _generateFirstPage() {
    return _pageLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KPLAssetImage(
              'recived_success',
              width: 93,
              height: 62,
            ),
            Gaps.vGap20,
            Text(
              '领取成功',
              style: TextStyles.text35M32,
            ),
            Gaps.vGap36,
            SizedBox(
              width: 154,
              child: Text(
                '恭喜您获得一节50分钟 1对1钢琴免费体验课',
                style: TextStyles.text66R15,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.vGap50,
            GradientButton(
              title: '点此预约',
              onPressed: () {
                _jumpToPage(1);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _generateSecondPage() {
    return _pageLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '立即预约上课',
              style: TextStyles.text35M23,
            ),
            Text(
              '( 选择上课时间 )',
              style: TextStyles.text66R15,
            ),
            Gaps.vGap40,
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 13,
              children: <Widget>[
                for (String key in dates.keys)
                  _generateSecondPageItem(key, dates[key]),
              ],
            ),
            Gaps.vGap36,
            GradientButton(
              title: '点此预约',
              onPressed: () async {
                if (_selectKey.isNotEmpty) {
                  var res = await _appointmentClass();
                  if (res.status) {
                    Application().userInfo.status = 3;
                    Application().setLocalInfo(Application().userInfo.toJson());
                    _jumpToPage(2);
                  } else {
                    KPLToast.show(res.msg);
                  }
                } else {
                  KPLToast.show('请先选择上课时间');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _generateSecondPageItem(String key, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectKey = key;
        });
      },
      child: Container(
        width: 130,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: _selectKey == key ? KplColor.red : KplColor.light_bgc_2),
          color: KplColor.light_bgc_2,
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyles.title9BR16,
          ),
        ),
      ),
    );
  }

  Widget _generateThirdPage() {
    return _pageLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            KPLAssetImage(
              'recived_success',
              width: 93,
              height: 62,
            ),
            Gaps.vGap20,
            Text(
              '预约信息已提交',
              style: TextStyles.text35M19,
            ),
            Gaps.vGap16,
            Text(
              '稍候会有课程顾问使用',
              style: TextStyles.text66R15,
            ),
            Text(
              '座机电话与您联系',
              style: TextStyles.text66R15,
            ),
          ],
        ),
      ),
    );
  }
}
