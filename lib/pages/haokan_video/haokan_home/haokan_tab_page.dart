import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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

  @override
  void initState() {
    super.initState();
    viewModel = HaoKanHomeViewModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.requestData(type: widget.type).then((value) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      onRefresh: () async {
        viewModel.requestData(type: widget.type, pageNum: 1).then((value) {
          if (mounted) {
            setState(() {});
          }
        });
      },
      onLoad: () async {
        viewModel
            .requestData(type: widget.type, pageNum: viewModel.pageNumber)
            .then((value) {
          if (mounted) {
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
                RouteManager.shortVideo,
                // RouteManager.dramaDetail,
                // arguments: DramaCoverModel(
                //   dramaId: model.firstEpisodes,
                //   coverUrl: model.verticalImage,
                // ),
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
