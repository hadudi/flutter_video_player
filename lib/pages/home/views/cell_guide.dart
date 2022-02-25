// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/routes/route_manager.dart';

import '../model/home_model.dart';

class GuideViewCell extends StatefulWidget {
  GuideViewCell({
    Key? key,
    required this.itemArray,
  }) : super(key: key);

  List<GuideModel>? itemArray;

  @override
  _GuideViewCellState createState() => _GuideViewCellState();
}

class _GuideViewCellState extends State<GuideViewCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.count(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        scrollDirection: Axis.horizontal,
        crossAxisSpacing: 0,
        mainAxisSpacing: 6,
        crossAxisCount: 1,
        childAspectRatio: 200 / 160,
        children: ((widget.itemArray ?? []).map(
          (e) => GestureDetector(
            child: GuideViewItemCell(model: e),
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.dramaDetail,
                arguments: DramaCoverModel(
                  dramaId: '${e.id}',
                  coverUrl: e.imgUrl,
                ),
              );
            },
          ),
        )).toList(),
      ),
    );
  }
}

class GuideViewItemCell extends StatefulWidget {
  GuideViewItemCell({
    Key? key,
    required this.model,
  }) : super(key: key);

  GuideModel? model;
  @override
  _GuideViewItemCellState createState() => _GuideViewItemCellState();
}

class _GuideViewItemCellState extends State<GuideViewItemCell> {
  @override
  Widget build(BuildContext context) {
    num score = widget.model?.filmScore ?? 0;
    List<Widget> stars = List.generate(
      (score.ceil() ~/ 2),
      (index) => const Icon(
        Icons.star,
        color: Color(0xfffb6060),
        size: 10,
      ),
    );

    return SizedBox(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.network(
              widget.model?.imgUrl ?? '',
              fit: BoxFit.cover,
              width: 160,
              height: 120,
              frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.model?.filmTitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff32383A),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.model?.filmSubtitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff868996),
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${widget.model?.filmScore ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xffFB6060),
                  fontSize: 10 * 4 / 3,
                  // fontFamily: 'Bebas',
                ),
              ),
              ...stars, //展开操作符 ... 能够把 list、set、map 字面量里的元素插入到一个集合中。一个对象是否可用于展开操作符取决于是否继承了Iterable，Map集合例外，对 map 进行展开操作 实际上是 调用了 Map 的 entries.iterator(),如果被展开的对象可能为 null，需要在展开操作符后面加上 ? 号 (...?)
            ],
          ),
        ],
      ),
    );
  }
}
