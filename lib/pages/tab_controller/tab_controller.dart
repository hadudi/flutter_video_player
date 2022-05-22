import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_home_page.dart';
import 'package:flutter_video_player/pages/home/page/home_page.dart';
import 'package:flutter_video_player/pages/hot_video/hot_video_page.dart';
import 'package:flutter_video_player/pages/mine/mine_page.dart';

import '../../util/util.dart';
import '../category/page/category_page.dart';

enum PageType {
  home,
  hotVideo,
  category,
  comment,
  mine,
}

class JJTabItem {
  late PageType type;
  late String? title;
  late IconData icon;
  late double iconSize;
  late Color? color;

  JJTabItem({
    required this.type,
    required this.title,
    required this.icon,
    this.iconSize = 26.0,
    this.color,
  });
}

class RootTabViewController extends StatefulWidget {
  const RootTabViewController({Key? key}) : super(key: key);

  @override
  _RootTabViewControllerState createState() => _RootTabViewControllerState();
}

class _RootTabViewControllerState extends State<RootTabViewController> {
  var _currentIndex = 0;
  var _hotIndex = false;

  /// 页面
  List<JJTabItem> get pages => [
        JJTabItem(
          type: PageType.home,
          title: R.Str.home,
          icon: Icons.home,
        ),
        JJTabItem(
          type: PageType.hotVideo,
          title: null,
          icon: Icons.video_collection,
          iconSize: 34,
          color: Colors.orange,
        ),
        JJTabItem(
          type: PageType.category,
          title: R.Str.category,
          icon: Icons.category,
        ),
        JJTabItem(
          type: PageType.comment,
          title: R.Str.hotComment,
          icon: Icons.comment,
        ),
        JJTabItem(
          type: PageType.mine,
          title: R.Str.mine,
          icon: Icons.person,
        ),
      ];

  late CupertinoTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = CupertinoTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // 页面没有缓存状态，包装一层
    return Scaffold(
      body: CupertinoTabScaffold(
        controller: _tabController,
        tabBar: _tabBar,
        tabBuilder: (context, index) => _tabBuilder(context, index),
      ),
    );
  }

  CupertinoTabBar get _tabBar => CupertinoTabBar(
        currentIndex: _currentIndex,
        items: pages
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(
                  e.icon,
                  size: e.iconSize,
                  color: e.color,
                ),
                label: e.title,
              ),
            )
            .toList(),
        activeColor: const Color(0xFFFB6060),
        inactiveColor: const Color(0xFFADB6C2),
        backgroundColor: _hotIndex ? const Color(0xff2d2d2d) : Colors.white,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFB2B8C2),
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
        onTap: (index) => setState(() {
          _currentIndex = index;
          _hotIndex = index == 1;
          switch (_currentIndex) {
            case 0:
            case 1:
            case 4:
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              break;
            default:
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              break;
          }
        }),
      );

  Widget _tabBuilder(BuildContext context, int index) {
    JJTabItem item = pages[index];
    Widget page = Container();
    switch (item.type) {
      case PageType.home:
        page = const HomePage();
        break;
      case PageType.hotVideo:
        page = const HaoKanHomePage();
        break;
      case PageType.category:
        page = const CategoryViewPage();
        break;
      case PageType.comment:
        page = const HotVideoPage();
        break;
      case PageType.mine:
        page = const MinePageView();
        break;
    }
    return page;
  }
}
