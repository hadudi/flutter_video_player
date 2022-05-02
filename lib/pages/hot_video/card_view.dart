import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/util/util.dart';
import 'bilibili_model.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RecommendModel model;

  @override
  Widget build(BuildContext context) {
    final w = (Util.appWidth - 30) / 2.0;
    final h = w * 148 / 208;
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExtendedImage.network(
            model.item?.pictures?.first.imgSrc ?? '',
            fit: BoxFit.cover,
            clearMemoryCacheWhenDispose: true,
            width: w,
            height: h,
            cacheWidth: w.toInt(),
            cacheHeight: h.toInt(),
            cacheMaxAge: const Duration(days: 1),
            enableLoadState: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Text(
              model.item?.title ?? '',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff333333),
              ),
            ),
          ),
          SizedBox(
            width: w,
            child: Stack(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(left: 12, right: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    model.user?.headUrl ?? '',
                    fit: BoxFit.cover,
                    cacheWidth: 24,
                    cacheHeight: 24,
                  ),
                ),
                Positioned(
                  left: 46,
                  right: 10,
                  height: 24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.user?.name ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff999999),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
