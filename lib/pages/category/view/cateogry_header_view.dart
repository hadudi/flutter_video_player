// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/category/view/category_item_view.dart';
import 'package:flutter_video_player/util/util.dart';

import '../view_model/category_view_model.dart';

class CategoryHeaderView extends StatefulWidget {
  CategoryHeaderView({
    Key? key,
    required this.viewModel,
    this.filterCallback,
  }) : super(key: key);

  CategoryViewModel viewModel;
  VoidCallback? filterCallback;

  @override
  _CategoryHeaderViewState createState() => _CategoryHeaderViewState();
}

class _CategoryHeaderViewState extends State<CategoryHeaderView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Util.appWidth,
      height: widget.viewModel.groupArray.length * 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.viewModel.groupArray.map((e) {
          return CategoryItemView(
            model: e,
            enable:
                !(e.drameType == 'MOVIE' && e.groupType == 'serializedStatus'),
            onTap: (index) {
              e.groupIndex = index;
              var key = e.groupType;
              var value = e.itemArray[index].idStr;
              widget.viewModel.filterParams[key] = value;
              if (e.groupType == 'dramaType') {
                widget.viewModel.groupArray
                        .firstWhere((element) =>
                            element.groupType == 'serializedStatus')
                        .drameType =
                    (key == 'dramaType' && value == 'MOVIE') ? 'MOVIE' : '';
              }
              widget.filterCallback?.call();
            },
          );
        }).toList(),
      ),
    );
  }
}
