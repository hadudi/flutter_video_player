// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/cache/cache_page.dart';
import 'package:flutter_video_player/pages/mine/mine_page.dart';
import 'package:flutter_video_player/pages/setting/setting_page.dart';
import 'package:flutter_video_player/pages/web/web_page.dart';

import '../models/models.dart';
import '../pages/drama_detail/page/drama_detail_page.dart';
import '../pages/drama_list/drama_list_page.dart';
import '../pages/haokan_video/short_video/haokan_short_video_page.dart';
import '../pages/login/login_page.dart';
import '../pages/tab_controller/tab_controller.dart';

class RouteManager {
  static const root = '/root';
  static const dramaDetail = '/dramaDetail';
  static const dramaList = '/dramaList';
  static const login = '/login';
  static const fullScreenPlayer = '/fullScreenPlayer';
  static const webPage = '/webPage';
  static const mine = '/mine';
  static const setting = '/setting';
  static const cache = '/cache';
  static const category = '/category';
  static const shortVideo = '/shortVideo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case root:
          return const RootTabViewController();
        case dramaDetail:
          return DramaDetailPageView(
            model: (settings.arguments is DramaCoverModel)
                ? (settings.arguments as DramaCoverModel)
                : null,
          );
        case dramaList:
          return DramaListPageView(
            model: (settings.arguments is DramaCoverModel)
                ? (settings.arguments as DramaCoverModel)
                : null,
          );
        case login:
          return const LoginPageView();
        case fullScreenPlayer:
          // var isVc = settings.arguments.runtimeType is VideoPlayerLayer;
          return Container();
        case webPage:
          return WebViewPage(
            url: settings.arguments as String,
          );
        case mine:
          return const MinePageView();
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

class CFNavigatorObservers extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
