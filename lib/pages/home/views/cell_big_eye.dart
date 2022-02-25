// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/routes/route_manager.dart';
import 'package:flutter_video_player/util/util.dart';

import '../model/home_model.dart';

typedef IndexChanged = void Function(int index);

class BigEyeViewCell extends StatefulWidget {
  BigEyeViewCell({
    Key? key,
    this.modelList,
    this.indexChanged,
  }) : super(key: key);
  List<BigEyeModel>? modelList;
  final IndexChanged? indexChanged;

  @override
  _BigEyeViewCellState createState() => _BigEyeViewCellState();
}

class _BigEyeViewCellState extends State<BigEyeViewCell> {
  late final ValueNotifier<int> indexNotify = ValueNotifier<int>(0);

  @override
  void dispose() {
    indexNotify.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 24);
    var height = (width / Util.bigEyeImgRatio + 40);
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 12,
            right: 12,
            bottom: 10,
            height: 60,
            child: Image.asset(
              R.Img.pic_banner_shadow,
            ),
          ),
          Positioned(
            top: 0,
            left: 12,
            right: 12,
            height: width / Util.bigEyeImgRatio,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.modelList?[index].imgUrl ?? '',
                          fit: BoxFit.cover,
                          width: width,
                          height: height,
                        );
                      },
                      itemCount: widget.modelList?.length ?? 0,
                      containerWidth: width,
                      containerHeight: height,
                      autoplay: true,
                      onIndexChanged: (value) {
                        indexNotify.value = value;
                        widget.indexChanged?.call(value);
                      },
                      onTap: (index) {
                        BigEyeModel? model = widget.modelList?[index];
                        DramaCoverModel? arg;
                        if (model?.type == 'movie') {
                          arg = DramaCoverModel(
                              dramaId: model?.targetUrl,
                              coverUrl: model?.imgUrl);
                        } else if (model?.redirectUrl?.isNotEmpty == true) {
                          Uri ret = Uri.parse(model!.redirectUrl!);
                          arg = DramaCoverModel(
                              dramaId: ret.queryParameters['seasonId'],
                              coverUrl: ret.queryParameters['imgUrl'] ??
                                  model.imgUrl);
                        }
                        Navigator.pushNamed(
                          context,
                          RouteManager.dramaDetail,
                          arguments: arg,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 120,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0x99000000)],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.play_circle_rounded,
                      size: 88,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 16,
                    right: 90,
                    child: ValueListenableBuilder<int>(
                      valueListenable: indexNotify,
                      builder: (context, index, child) {
                        BigEyeModel? model = widget.modelList?[index];
                        String title = model?.name ?? (model?.filmTitle ?? '');
                        String subTitle = model?.title?.isNotEmpty == true
                            ? (model?.title ?? '')
                            : (model?.filmSubtitle ?? '');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: subTitle.isEmpty
                              ? <Widget>[
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                              : <Widget>[
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    subTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
