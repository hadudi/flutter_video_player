// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names

typedef R = ResourceRef;

/// 资源名管理器
/// 图片
class Imgs {
  Imgs._();
  static final instance = Imgs._();

  ///gif
  final ic_playing = 'resource/image/ic_playing.gif';

  ///png
  final ic_vip = 'resource/image/ic_vip.png';
  final pic_banner_shadow = 'resource/image/pic_banner_shadow.png';
  final pic_Avatar_n = 'resource/image/pic_Avatar_n.png';
  final pic_Avatar_h = 'resource/image/pic_Avatar_h.png';
  final splas_logo = 'resource/image/splas_logo.png';

  final cover_img = 'resource/image/cover_img.png';

  final haokan_logo = 'resource/image/haokan_logo.png';

  final splash_shake = 'resource/image/splash_shake.png';
}

/// 字符串
class Strs {
  Strs._();
  static final instance = Strs._();

  final firstLaunch = 'FirstLaunch';

  final home = '首页';
  final haokanVideo = '好看';
  final hotVideo = 'Hot';
  final category = '分类';
  final hotComment = '漫画';
  final mine = '我的';
}

class JsonPath {
  JsonPath._();
  static final instance = JsonPath._();

  final homePage = 'resource/json/home_page.json';
  final minePage = 'resource/json/mine_page.json';

  final categoryFilter = 'resource/json/category_filters.json';
  final categoryPage1 = 'resource/json/category_list_page1.json';
  final categoryPage2 = 'resource/json/category_list_page2.json';

  final dramaDetail = 'resource/json/drama_info_detail.json';

  final play1Detail = 'resource/json/play1_info_detail.json';
  final play2Detail = 'resource/json/play2_info_detail.json';
  final play3Detail = 'resource/json/play3_info_detail.json';
  final play4Detail = 'resource/json/play4_info_detail.json';

  final loginSendCode = 'resource/json/login_send_code.json';
  final loginUserInfo = 'resource/json/user_info.json';
}

class ResourceRef {
  ResourceRef._();

  static final Img = Imgs.instance;
  static final Str = Strs.instance;
  static final Jsp = JsonPath.instance;
}
