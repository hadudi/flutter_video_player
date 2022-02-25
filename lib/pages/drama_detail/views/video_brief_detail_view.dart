import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/drama_detail/model/video_info_model.dart';

class VideoBriefDetailView extends StatelessWidget {
  const VideoBriefDetailView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final VideoInfoModel? model;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(right: 12, bottom: 6),
            child: Text(
              model?.drama?.title ?? '剧名',
              maxLines: 2,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xff3b4051),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              model?.drama?.enName ?? '',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xffadb6c2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 4, bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    model?.drama?.info ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xffadb6c2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 28),
            child: Text(
              model?.drama?.brief ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff868996),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
