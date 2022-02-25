// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/routes/route_manager.dart';

import '../model/home_model.dart';
import 'cell_list.dart';

class MultiItemCell extends StatefulWidget {
  MultiItemCell({
    Key? key,
    this.model,
  }) : super(key: key);

  HomePageModel? model;

  @override
  _MultiItemCellState createState() => _MultiItemCellState();
}

class _MultiItemCellState extends State<MultiItemCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: (widget.model?.itemArray ?? []).isNotEmpty ? 38 : 0,
          child: GestureDetector(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    widget.model?.title ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text(
                    '更多',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffadb6c2),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.dramaList,
                arguments: DramaCoverModel(
                  coverUrl: widget.model?.title,
                  dramaId: widget.model?.redirectUrl,
                ),
              );
            },
          ),
        ),
        SizedBox(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 6,
            runSpacing: 6,
            children: ((widget.model?.itemArray as List<SectionContentModel>)
                .map(
                  (e) => (GestureDetector(
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
                  )),
                )
                .toList()),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
