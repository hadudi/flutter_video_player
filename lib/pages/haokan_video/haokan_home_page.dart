import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/home/model/home_model.dart';
import '../../models/models.dart';
import '../../routes/route_manager.dart';
import '../../util/util.dart';
import '../home/views/cell_list.dart';
import 'haokan_home_view_model.dart';
import 'haokan_home_model.dart';

class HaoKanHomePage extends StatefulWidget {
  const HaoKanHomePage({Key? key}) : super(key: key);

  @override
  _HaoKanHomePageState createState() => _HaoKanHomePageState();
}

class _HaoKanHomePageState extends State<HaoKanHomePage> {
  late HaoKanHomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HaoKanHomeViewModel();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      viewModel.requestData().then((value) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Util.navBarHeight,
        backgroundColor: Colors.black,
        leadingWidth: 200,
        leading: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Image.asset(
                R.Img.haokan_logo,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              '好看视频',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 6,
          childAspectRatio: 0.564,
        ),
        itemCount: viewModel.pageModelList.length,
        itemBuilder: (ctx, index) {
          DramaItemModel model = viewModel.pageModelList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.dramaDetail,
                arguments: DramaCoverModel(
                  dramaId: model.firstEpisodes,
                  coverUrl: model.verticalImage,
                ),
              );
            },
            child: ListCell(
              model: SectionContentModel(
                int.tryParse('${model.firstEpisodes}'),
                model.videoName,
                model.verticalImage,
                '${model.seriesNum}集${model.isFinish == '1' ? '全' : ' 连载中'}',
              ),
            ),
          );
        },
      ),
    );
  }
}
