import 'package:flutter/material.dart';
import 'haokan_short_video_item_view.dart';
import 'haokan_short_video_view_model.dart';

class HaoKanShortVideoPage extends StatefulWidget {
  const HaoKanShortVideoPage({
    super.key,
    required this.active,
  });

  final bool active;

  @override
  State<HaoKanShortVideoPage> createState() => _HaoKanShortVideoPageState();
}

class _HaoKanShortVideoPageState extends State<HaoKanShortVideoPage> {
  late final HaoKanShortVideoViewModel viewModel;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    viewModel = HaoKanShortVideoViewModel();
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        viewModel.requestData(pageNum: viewModel.pageNumber).then((value) {
          if (mounted) {
            setState(() {});
          }
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.requestData().then((value) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.requestData().then((value) {
            if (mounted) {
              setState(() {});
            }
          });
        },
        child: PageView.builder(
          itemCount: viewModel.videoList.length,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, index) {
            return HaoKanShortVideoItemView(
              model: viewModel.videoList[index],
              active: widget.active,
            );
          },
        ),
      ),
    );
  }
}
