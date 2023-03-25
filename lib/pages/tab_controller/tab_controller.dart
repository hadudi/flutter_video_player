import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/haokan_video/short_video/haokan_short_video_page.dart';
import 'package:flutter_video_player/pages/tab_controller/tabbar.dart';
import 'package:flutter_video_player/providers/config_provider.dart';
import 'package:provider/provider.dart';
import '../haokan_video/haokan_home/haokan_home_page.dart';

class RootTabViewController extends StatefulWidget {
  const RootTabViewController({Key? key}) : super(key: key);

  @override
  _RootTabViewControllerState createState() => _RootTabViewControllerState();
}

class _RootTabViewControllerState extends State<RootTabViewController>
    with SingleTickerProviderStateMixin {
  late final PageController _tabController;
  late final PageView _pageView;

  /// 页面
  List<JJTabItem> get _tabItems => [
        JJTabItem(
          type: PageType.home,
          icon: Icons.home,
          title: "首页",
        ),
        JJTabItem(
          type: PageType.video,
          icon: Icons.ondemand_video_rounded,
          title: "短视频",
        ),
      ];

  @override
  void initState() {
    super.initState();
    _tabController = PageController();
    _pageView = PageView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: _tabItems.map((e) {
        Widget page = Container();
        switch (e.type) {
          case PageType.home:
            page = const HaoKanHomePage();
            break;
          case PageType.video:
            page = const HaoKanShortVideoPage();
            break;
        }
        return page;
      }).toList(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageView,
      bottomNavigationBar: CustomTabbar(
        tabItems: _tabItems,
        callback: (index) {
          context.read<ConfigProvider>().changeIndex(index);
          _tabController.jumpToPage(index);
        },
      ),
    );
  }
}
