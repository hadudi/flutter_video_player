import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_video_detail/haokan_video_detail_model.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_video_detail/haokan_video_detail_vm.dart';
import 'package:flutter_video_player/util/util.dart';
// import '../views/small_screen_placeholder_view.dart';

class DramaDetailPageView extends StatefulWidget {
  const DramaDetailPageView({
    Key? key,
    // required this.model,
  }) : super(key: key);

  // final DramaCoverModel? model;

  @override
  _DramaDetailPageViewState createState() => _DramaDetailPageViewState();
}

class _DramaDetailPageViewState extends State<DramaDetailPageView> {
  late final DramaDetailViewModel viewModel;

  late final ValueNotifier<VodDetailData?> playInfoNotify =
      ValueNotifier<VodDetailData?>(null);
  late final ValueNotifier<bool> fullScreenNotify = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    viewModel = DramaDetailViewModel();
    viewModel.requestData(dramaId: '').then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (mounted) {
          setState(() {});
        }
        // await viewModel.requestPlayInfo(
        //     dramaId: widget.model?.dramaId,
        //     episodeId: value?.playInfo?.episodeSid);
        // if (viewModel.playInfoModel != null) {
        //   playInfoNotify.value = viewModel.playInfoModel;
        // }
      });
    });
  }

  @override
  void dispose() {
    playInfoNotify.dispose();
    fullScreenNotify.dispose();
    super.dispose();
  }

  Widget get bodyView {
    var width = MediaQuery.of(context).size.width;
    var height = width * 0.56;
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: fullScreenNotify.value ? 0 : Util.statusBarHeight,
            color: Colors.black,
          ),
          SizedBox(
            height: fullScreenNotify.value
                ? MediaQuery.of(context).size.height
                : height,
            child: Stack(
              children: [
                // Positioned(
                //   child: ValueListenableBuilder<VodDetailData?>(
                //     valueListenable: playInfoNotify,
                //     builder: (context, PlayInfoModel? model, child) {
                //       if (model == null) {
                //         return child ?? const SizedBox.shrink();
                //       }
                //       return VideoPlayerLayer(
                //         smallScreenCallback: () {
                //           fullScreenNotify.value = false;
                //         },
                //         fullScreenCallback: () {
                //           fullScreenNotify.value = true;
                //         },
                //         nextSourceCallback: () async {
                //           // int? episodeSid =
                //           //     viewModel.videoInfoModel?.nextEpisode?.episodeSid;
                //           // await viewModel.requestPlayInfo(
                //           //   dramaId: widget.model?.dramaId,
                //           //   episodeId: episodeSid,
                //           // );
                //           // if (viewModel.playInfoModel != null) {
                //           //   playInfoNotify.value = viewModel.playInfoModel;
                //           //   setState(() {});
                //           // }
                //         },
                //       );
                //     },
                //     child: Offstage(
                //       offstage: fullScreenNotify.value,
                //       child: SmallScreenPlayerPlaceHolderView(
                //         coverUrl: widget.model?.coverUrl ?? '',
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Offstage(
                    offstage: fullScreenNotify.value,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 2,
              itemBuilder: (ctx, index) {
                // if (index == 0) {
                //   return const VideoBriefView();
                // } else if (index == 1) {
                //   return VideoSeriesView(
                //     switchEpisodeCallback: (episodeId) {
                //       // viewModel
                //       //     .requestPlayInfo(
                //       //         dramaId: widget.model?.dramaId,
                //       //         episodeId: episodeId)
                //       //     .then((value) {
                //       //   if (viewModel.playInfoModel != null) {
                //       //     playInfoNotify.value = viewModel.playInfoModel;
                //       //     setState(() {});
                //       //   }
                //       // });
                //     },
                //   );
                // }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: ValueListenableBuilder<bool>(
        //   valueListenable: fullScreenNotify,
        //   builder: (context, value, child) {
        //     return value
        //         ? WillPopScope(
        //             child: DramaPlayInfoWidget(
        //               viewModel: viewModel,
        //               child: bodyView,
        //             ),
        //             onWillPop: () async => false,
        //           )
        //         : DramaPlayInfoWidget(
        //             viewModel: viewModel,
        //             child: bodyView,
        //           );
        //   },
        // ),
        );
  }
}
