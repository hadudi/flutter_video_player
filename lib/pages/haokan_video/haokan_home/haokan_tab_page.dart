import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../models/models.dart';
import '../../../routes/route_manager.dart';
import '../../home/model/home_model.dart';
import '../../home/views/cell_list.dart';
import 'haokan_home_model.dart';
import 'haokan_home_view_model.dart';

class HaoKanHomeTabPage extends StatefulWidget {
  const HaoKanHomeTabPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final DramaType type;

  @override
  State<HaoKanHomeTabPage> createState() => _HaoKanHomeTabPageState();
}

class _HaoKanHomeTabPageState extends State<HaoKanHomeTabPage>
    with AutomaticKeepAliveClientMixin {
  late HaoKanHomeViewModel viewModel;

  late final RefreshController _controller;

  @override
  void initState() {
    super.initState();
    viewModel = HaoKanHomeViewModel();
    _controller = RefreshController(initialRefresh: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.requestData(type: widget.type).then((value) {
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
    super.build(context);
    return SmartRefresher(
      enablePullUp: true,
      controller: _controller,
      onRefresh: () async {
        viewModel.requestData(type: widget.type, pageNum: 1).then((value) {
          if (mounted) {
            _controller.refreshCompleted();
            setState(() {});
          }
        });
      },
      onLoading: () async {
        viewModel
            .requestData(type: widget.type, pageNum: viewModel.pageNumber)
            .then((value) {
          if (mounted) {
            _controller.loadComplete();
            setState(() {});
          }
        });
      },
      child: GridView.builder(
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

  @override
  bool get wantKeepAlive => true;
}
