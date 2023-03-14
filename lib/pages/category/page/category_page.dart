// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/pages/category/view_model/category_view_model.dart';
import 'package:flutter_video_player/pages/home/views/cell_list.dart';
import 'package:flutter_video_player/routes/route_manager.dart';
import 'package:flutter_video_player/util/util.dart';

import '../view/cateogry_header_view.dart';

class CategoryViewPage extends StatefulWidget {
  const CategoryViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryViewPageState createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage>
    with AutomaticKeepAliveClientMixin {
  late final CategoryViewModel viewModel;

  bool select = false;
  ValueNotifier<bool> showTitleNotify = ValueNotifier(false);
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    viewModel = CategoryViewModel();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (mounted) {
        double extent = _scrollController.offset;
        double height = viewModel.groupArray.length * 44 - 32;
        if (extent >= height) {
          if (showTitleNotify.value == false) {
            showTitleNotify.value = true;
          }
        } else {
          if (showTitleNotify.value) {
            showTitleNotify.value = false;
          }
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await viewModel.fetchCategory();
      await viewModel.fetchCategoryContent();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    showTitleNotify.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Util.navBarHeight,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xfff3f6f8),
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: BoxConstraints(
              maxWidth: Util.appWidth,
              minHeight: 30,
            ),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 12, right: 8),
                  child: Icon(
                    Icons.search,
                    size: 12,
                    color: Color(0xffadb6c2),
                  ),
                ),
                Text(
                  '搜索你想找的剧集',
                  style: TextStyle(fontSize: 12, color: Color(0xffadb6c2)),
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
            color: null,
            backgroundColor: null,
            strokeWidth: 0,
            displacement: 20,
            edgeOffset: viewModel.groupArray.length * 44,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  collapsedHeight: 32,
                  toolbarHeight: 32,
                  shadowColor: Colors.black.withAlpha(25),
                  title: ValueListenableBuilder<bool>(
                    valueListenable: showTitleNotify,
                    builder: (context, value, child) {
                      return Offstage(
                        offstage: !value,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            viewModel.filterTitle,
                            style: const TextStyle(
                              color: Color(0xfffb6060),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  expandedHeight: viewModel.groupArray.length * 44 + 10,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: CategoryHeaderView(
                      viewModel: viewModel,
                      filterCallback: () async {
                        await viewModel.fetchCategoryContent();
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverGrid.count(
                    crossAxisCount: 3,
                    childAspectRatio: 0.564,
                    crossAxisSpacing: 6,
                    children: viewModel.contentArray
                        .map(
                          (e) => GestureDetector(
                            child: ListCell(
                              model: e,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteManager.dramaDetail,
                                arguments: DramaCoverModel(
                                  dramaId: '${e.dramaId}',
                                  coverUrl: e.coverUrl,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            onRefresh: () async {
              await viewModel.fetchCategoryContent();
              setState(() {});
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
