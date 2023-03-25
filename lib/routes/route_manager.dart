// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/cache/cache_page.dart';
import 'package:flutter_video_player/pages/setting/setting_page.dart';

import '../pages/drama_detail/page/drama_detail_page.dart';
import '../pages/haokan_video/short_video/haokan_short_video_page.dart';
import '../pages/tab_controller/tab_controller.dart';

class RouteManager {
  static const root = '/root';
  static const dramaDetail = '/dramaDetail';
  static const setting = '/setting';
  static const cache = '/cache';
  static const shortVideo = '/shortVideo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case root:
          return const RootTabViewController();
        case dramaDetail:
          return const DramaDetailPageView();
        case setting:
          return const SettiingViewPage();
        case cache:
          return const CacheViewPage();
        case shortVideo:
          return const HaoKanShortVideoPage();
        default:
          return const Scaffold();
      }
    });
  }
}
