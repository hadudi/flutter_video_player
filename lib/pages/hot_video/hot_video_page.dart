import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_video_player/util/util.dart';
import 'card_view.dart';
import 'hot_video_view_model.dart';

class HotVideoPage extends StatefulWidget {
  const HotVideoPage({Key? key}) : super(key: key);

  @override
  State<HotVideoPage> createState() => _HotVideoPageState();
}

class _HotVideoPageState extends State<HotVideoPage> {
  late HotVideoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HotVideoViewModel();
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
    final count = viewModel.pageModelList.length;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Util.navBarHeight,
        title: const Text(
          'Bilibili',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SizedBox(
        child: EasyRefresh(
          header: BallPulseHeader(),
          footer: BallPulseFooter(),
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: count,
            itemBuilder: (ctx, index) => CardView(
              model: viewModel.pageModelList[index],
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 12,
              crossAxisSpacing: 6,
              childAspectRatio: 14 / 15,
              crossAxisCount: 2,
            ),
          ),
          onRefresh: () async {
            viewModel.requestData().then((value) {
              if (mounted) {
                setState(() {});
              }
            });
          },
          onLoad: () async {
            viewModel.requestData(pageNum: viewModel.pageNumber).then((value) {
              if (mounted) {
                setState(() {});
              }
            });
          },
        ),
      ),
    );
  }
}
