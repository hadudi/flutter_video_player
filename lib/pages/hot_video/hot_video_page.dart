import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/util/util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'card_view.dart';
import 'hot_video_view_model.dart';

class HotVideoPage extends StatefulWidget {
  const HotVideoPage({Key? key}) : super(key: key);

  @override
  State<HotVideoPage> createState() => _HotVideoPageState();
}

class _HotVideoPageState extends State<HotVideoPage> {
  late HotVideoViewModel viewModel;

  final RefreshController _controller =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    viewModel = HotVideoViewModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.requestData().then((value) {
        _controller.refreshCompleted();
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SmartRefresher(
        enablePullUp: true,
        controller: _controller,
        onRefresh: () async {
          viewModel.requestData().then((value) {
            if (mounted) {
              _controller.refreshCompleted();
              setState(() {});
            }
          });
        },
        onLoading: () async {
          viewModel.requestData(pageNum: viewModel.pageNumber).then((value) {
            if (mounted) {
              _controller.loadComplete();
              setState(() {});
            }
          });
        },
        child: WaterfallFlow.builder(
          padding: const EdgeInsets.all(12.0),
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 12.0,
            collectGarbage: (List<int> garbages) {
              for (var index in garbages) {
                final provider = ExtendedNetworkImageProvider(
                  viewModel.pageModelList[index].item?.pictures?.first.imgSrc ??
                      '',
                );
                provider.evict();
              }
            },
            lastChildLayoutTypeBuilder: (index) =>
                index == viewModel.pageModelList.length
                    ? LastChildLayoutType.foot
                    : LastChildLayoutType.none,
          ),
          itemCount: viewModel.pageModelList.length,
          itemBuilder: (BuildContext context, int index) {
            return CardView(
              model: viewModel.pageModelList[index],
            );
          },
        ),
      ),
    );
  }
}
