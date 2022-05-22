import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_tab_page.dart';
import '../../util/util.dart';
import 'haokan_home_view_model.dart';

class HaoKanHomePage extends StatelessWidget {
  const HaoKanHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: DramaType.values.length,
      child: Scaffold(
        backgroundColor: const Color(0xff2d2d2d),
        appBar: AppBar(
          toolbarHeight: Util.navBarHeight,
          backgroundColor: const Color(0xff2d2d2d),
          leadingWidth: 200,
          elevation: 0.1,
          title: Row(
            children: [
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: const Color(0xFFF93759),
                  indicatorWeight: 6,
                  indicatorPadding: kTabLabelPadding,
                  enableFeedback: false,
                  labelColor: const Color(0xffF93759),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: const Color(0xff8d8d8d),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  tabs: DramaType.values
                      .map(
                        (e) => Tab(text: e.name),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: DramaType.values
              .map(
                (e) => HaoKanHomeTabPage(type: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
