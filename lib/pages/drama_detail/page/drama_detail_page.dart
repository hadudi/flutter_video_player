import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/pages/drama_detail/model/play_info_model.dart';
import 'package:flutter_video_player/pages/player/video_player.dart';
import '../views/video_brief_detail_view.dart';
import '../views/video_brief_view.dart';
import '../views/video_episode_view.dart';
import '../views/video_series_view.dart';
import '../views/small_screen_placeholder_view.dart';
import '../../../models/models.dart';
import '../../../routes/route_manager.dart';
import '../../../util/util.dart';
import '../view_model/drama_detail_view_model.dart';

final GlobalKey playerKey = GlobalKey(debugLabel: 'playerKey');
final GlobalKey playerViewKey = GlobalKey(debugLabel: 'playerViewKey');

class DramaPlayInfoWidget extends InheritedWidget {
  const DramaPlayInfoWidget({
    Key? key,
    required this.viewModel,
    required Widget child,
  }) : super(key: key, child: child);

  final DramaDetailViewModel viewModel;

  static DramaPlayInfoWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DramaPlayInfoWidget>();
  }

  @override
  bool updateShouldNotify(covariant DramaPlayInfoWidget oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}

class DramaDetailPageView extends StatefulWidget {
  const DramaDetailPageView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DramaCoverModel? model;

  @override
  _DramaDetailPageViewState createState() => _DramaDetailPageViewState();
}

class _DramaDetailPageViewState extends State<DramaDetailPageView> {
  late final DramaDetailViewModel viewModel;

  late final ValueNotifier<PlayInfoModel?> playInfoNotify =
      ValueNotifier<PlayInfoModel?>(null);
  late final ValueNotifier<bool> fullScreenNotify = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    viewModel = DramaDetailViewModel();
    viewModel.requestData(dramaId: widget.model?.dramaId ?? '').then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (mounted) {
          setState(() {});
        }
        await viewModel.requestPlayInfo(
            dramaId: widget.model?.dramaId,
            episodeId: value?.playInfo?.episodeSid);
        if (viewModel.playInfoModel != null) {
          playInfoNotify.value = viewModel.playInfoModel;
        }
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
      key: playerKey,
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
                Positioned(
                  child: ValueListenableBuilder<PlayInfoModel?>(
                    valueListenable: playInfoNotify,
                    builder: (context, PlayInfoModel? model, child) {
                      if (model == null) {
                        return child ?? const SizedBox.shrink();
                      }
                      return VideoPlayerLayer(
                        smallScreenCallback: () {
                          fullScreenNotify.value = false;
                        },
                        fullScreenCallback: () {
                          fullScreenNotify.value = true;
                        },
                        nextSourceCallback: () async {
                          int? episodeSid =
                              viewModel.videoInfoModel?.nextEpisode?.episodeSid;
                          await viewModel.requestPlayInfo(
                            dramaId: widget.model?.dramaId,
                            episodeId: episodeSid,
                          );
                          if (viewModel.playInfoModel != null) {
                            playInfoNotify.value = viewModel.playInfoModel;
                            setState(() {});
                          }
                        },
                      );
                    },
                    child: Offstage(
                      offstage: fullScreenNotify.value,
                      child: const SmallScreenPlayerPlaceHolderView(
                        coverUrl:
                            'https://pic.rmb.bdstatic.com/baidu-rmb-video-cover-1/2021-7/1626194565491/6f3d7a62247e.jpg@s_0,w_800,h_1000,q_80',
                      ),
                    ),
                  ),
                ),
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
            child: Navigator(
              onPopPage: _onPopPage,
              initialRoute: '/content',
              onGenerateRoute: _onGenerateRoute,
              observers: [CFNavigatorObservers()],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: fullScreenNotify,
        builder: (context, value, child) {
          return value
              ? WillPopScope(
                  child: DramaPlayInfoWidget(
                    viewModel: viewModel,
                    child: bodyView,
                  ),
                  onWillPop: () async => false,
                )
              : DramaPlayInfoWidget(
                  viewModel: viewModel,
                  child: bodyView,
                );
        },
      ),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    return !fullScreenNotify.value;
  }

  Route _onGenerateRoute(RouteSettings settings) {
    return PageRouteBuilder(pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      Widget view = const SizedBox();
      switch (settings.name) {
        case '/content':
          view = ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return const VideoBriefView();
              } else if (index == 1) {
                return VideoSeriesView(
                  switchEpisodeCallback: (episodeId) {
                    viewModel
                        .requestPlayInfo(
                            dramaId: widget.model?.dramaId,
                            episodeId: episodeId)
                        .then((value) {
                      if (viewModel.playInfoModel != null) {
                        playInfoNotify.value = viewModel.playInfoModel;
                        setState(() {});
                      }
                    });
                  },
                );
              }
              return const SizedBox();
            },
          );
          break;
        case '/brief':
          view = VideoBriefDetailView(model: viewModel.videoInfoModel);
          break;
        case '/explosid':
          view = ExplosidListView(
            model: viewModel.videoInfoModel,
          );
          break;
      }

      return FadeTransition(
        opacity: animation,
        child: WillPopScope(
          child: view,
          onWillPop: () async => false,
        ),
      );
    });
  }
}
