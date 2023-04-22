// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_home/haokan_home_model.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_video_detail/haokan_video_detail_model.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_video_detail/haokan_video_detail_vm.dart';
// import 'package:flutter_video_player/providers/vod_item_provider.dart';
import 'package:flutter_video_player/util/util.dart';
import 'package:provider/provider.dart';
// import '../views/small_screen_placeholder_view.dart';

class DramaDetailPageView extends StatefulWidget {
  const DramaDetailPageView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DramaItemModel? model;

  @override
  _DramaDetailPageViewState createState() => _DramaDetailPageViewState();
}

class _DramaDetailPageViewState extends State<DramaDetailPageView> {
  late final VodDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = VodDetailViewModel();
    // viewModel
    //     .requestData(
    //   dramaId: widget.model?.firstEpisodes ?? "",
    // )
    //     .then((value) {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (timeStamp) async {
    //       if (mounted) {
    //         setState(() {});
    //       }
    //     },
    //   );
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _oriView(BuildContext context) {
    double kWidth = MediaQuery.of(context).size.width;
    double kHeight = MediaQuery.of(context).size.height;
    double height = kWidth * 0.56;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: OrientationBuilder(
          builder: (
            BuildContext context,
            Orientation orientation,
          ) {
            () async {
              if (orientation == Orientation.portrait) {
                await SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.edgeToEdge,
                );
              } else {
                await SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.immersiveSticky,
                );
              }
            }();

            return WillPopScope(
              onWillPop:
                  orientation == Orientation.portrait ? null : () async => true,
              child: AnimatedContainer(
                duration: const Duration(microseconds: 200),
                constraints: const BoxConstraints.expand(),
                margin: EdgeInsets.zero,
                color: const Color(0xE82D2D2D),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: orientation == Orientation.landscape
                          ? kHeight
                          : height,
                      child: Stack(
                        children: <Widget>[
                          // _coverV,
                          // const Positioned.fill(
                          //   child: VideoPlayerView(),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        itemBuilder: (ctx, index) {
                          // if (model?.vodPlayModels == null) {
                          //   return const SizedBox.shrink();
                          // }
                          // if (index == 0) {
                          //   return const VideoDetailSectionBriefView();
                          // } else if (index == 1) {
                          //   return const VideoDetailSectionEpisodesView();
                          // }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: viewModel.requestData(dramaId: "dramaId"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _oriView(context);
        },
      ),
    );
  }
}
