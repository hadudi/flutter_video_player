import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'haokan_home_model.dart';

class ListCell extends StatelessWidget {
  const ListCell({
    Key? key,
    this.model,
  }) : super(key: key);
  final DramaItemModel? model;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 36) / 3.0;
    final height = width * 1.4;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Hero(
                tag: model!.verticalImage!,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: ExtendedImage.network(
                    model?.verticalImage ?? '',
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                    cacheWidth: width.toInt(),
                    cacheHeight: height.toInt(),
                    cacheMaxAge: const Duration(days: 7),
                    enableLoadState: false,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 28,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(0),
                        Colors.black.withAlpha(153),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Text(
                  '${model?.seriesNum}集${model?.isFinish == "1" ? "全" : "连载中"}',
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 6),
            child: Text(
              model?.videoName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.0,
              style: const TextStyle(
                color: Color(0xFF32383A),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
