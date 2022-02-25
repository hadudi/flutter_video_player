// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/routes/route_manager.dart';

import '../model/home_model.dart';

class SingleImageViewCell extends StatelessWidget {
  SingleImageViewCell({
    Key? key,
    required this.model,
  }) : super(key: key);

  SectionContentModel? model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Image.network(
          model?.icon ?? '',
          fit: BoxFit.fitWidth,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.dramaDetail,
          arguments: DramaCoverModel(
            dramaId: '${model?.dramaId}',
            coverUrl: model?.coverUrl,
          ),
        );
      },
    );
  }
}
