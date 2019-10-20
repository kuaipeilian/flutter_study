import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

Header createRefreshHeader() {
  return ClassicalHeader(
    enableInfiniteRefresh: false,
    bgColor: Colors.transparent,
    textColor: Colors.black87,
    infoColor: Colors.black54,
    refreshText: "下拉刷新",
    refreshReadyText: "松开刷新",
    refreshingText: "刷新...",
    refreshedText: "刷新完成",
    showInfo: false,
  );
}

Footer createRefreshFooter() {
  return ClassicalFooter(
    loadText: '上拉加载',
    loadReadyText: '松开加载',
    loadingText: '加载中...',
    loadedText: '加载成功',
    loadFailedText: '加载失败',
    noMoreText: '没有更多数据',
    showInfo: false,
  );
}
