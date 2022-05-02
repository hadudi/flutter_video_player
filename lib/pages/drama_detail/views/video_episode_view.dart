import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/drama_detail/model/video_info_model.dart';

import '../../../util/util.dart';

class ExplosidListView extends StatefulWidget {
  const ExplosidListView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VideoInfoModel? model;

  @override
  _ExplosidListViewState createState() => _ExplosidListViewState();
}

class _ExplosidListViewState extends State<ExplosidListView> {
  VideoInfoModel? get model => widget.model;

  bool get hasText => (model?.episodeList?.first.text?.length ?? 0) > 2;

  @override
  Widget build(BuildContext context) {
    var serializedStatus = model?.drama?.serializedStatus?.isNotEmpty == true
        ? model?.drama?.serializedStatus
        : '未开播';
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Text(
                    '简介',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff32383a),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              serializedStatus ?? '',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xffadb6c2),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: hasText ? Util.appWidth - 24 : 54,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: hasText ? ((Util.appWidth - 24) / 54) : 1,
              ),
              itemCount: model?.episodeList?.length ?? 0,
              itemBuilder: (ctx, index) {
                Episode? episode = model?.episodeList?[index];
                String? text =
                    hasText ? episode?.text : '${episode?.episodeNo}';
                episode?.isSelected =
                    (model?.currentEpisode?.episodeSid == episode.episodeSid);
                Widget textWidget = Text(
                  '$text',
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: episode?.isSelected == true
                        ? const Color(0xffFB6060)
                        : const Color(0xff3b4051),
                  ),
                );
                return Container(
                  clipBehavior: Clip.hardEdge,
                  padding: !hasText
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 20),
                  alignment: hasText ? Alignment.centerLeft : Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xfff3f6f8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: (episode?.isSelected == true && !hasText)
                      ? Image.asset(R.Img.ic_playing)
                      : textWidget,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
