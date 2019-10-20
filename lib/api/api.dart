class Api {
  static const String BASE_URL_DEV = 'http://localhost:5800';
  // static const String BASE_URL_DEV = 'http://admin.100wlc.com';
  static const String BASE_URL_PRO = 'http://admin.kuaipeilian.com';
  static const String BASE_Web_DEV = 'http://news.100wlc.com';
  static const String BASE_Web_PRO = 'http://news.kuaipeilian.com';

  // 基本信息
  static const String POST_BASEINFO = '/api/base/vipinfo';
  // 获取验证码
  static const String POST_SMS = '/api/hermes/sendVerifyCode';
  static const String POST_CHECK_SMS = '/hermes/checkVerifyCode';
  static const String POST_LOGIN = '/api/register';
  // 获取约课时间
  static const String GET_RECEIVE_RESULTS = '/api/receive_results';
  // 推荐首页数据
  static const String GET_GROUPLIST = '/api/newsArticle/groupList';
  // 预约
  static const String POST_APP_APPOINTMENT = '/api/appointment';
  // home 首页数据
  static const String GET_APP_INFO = '/api/get_app_info';
  // 关于我们列表
  static const String GET_ABOUT_US_LIST = '/api/about_us/list';
  // 文章列表 currentPage, size, kinds
  static const String POST_ARTICLELIST = '/api/newsArticle/list';
  // appstore id
  static const String POST_APP_STROE_URL = 'https://itunes.apple.com/lookup?id=1478207076';
}