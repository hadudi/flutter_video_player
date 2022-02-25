import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/drama_detail/model/video_info_model.dart';
import 'package:flutter_video_player/pages/drama_detail/page/drama_detail_page.dart';

class VideoBriefView extends StatefulWidget {
  const VideoBriefView({
    Key? key,
  }) : super(key: key);
  @override
  _VideoBriefViewState createState() => _VideoBriefViewState();
}

class _VideoBriefViewState extends State<VideoBriefView> {
  VideoInfoModel? get model =>
      DramaPlayInfoWidget.of(context)?.viewModel.videoInfoModel;

  @override
  Widget build(BuildContext context) {
    num score = model?.drama?.score ?? 0;
    bool hasScore = score.ceil() == 0;
    List<Widget> stars = List.generate(
      hasScore ? 5 : (score.ceil() ~/ 2),
      (index) => Icon(
        Icons.star,
        color: hasScore ? Colors.grey : const Color(0xfffb6060),
        size: 10,
      ),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 4),
            child: Text(
              model?.drama?.title ?? '剧名',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
            padding: const EdgeInsets.only(right: 12, bottom: 5),
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
                const Spacer(),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 3),
                    width: 72,
                    height: 28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '全部简介',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffadb6c2),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Color(0xffadb6c2),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/brief');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 28),
            child: Text(
              model?.drama?.brief ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff868996),
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.drama?.score ?? '0'}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffb6060),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: stars,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Column(
                    children: const [
                      Icon(Icons.download_for_offline),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '下载',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffadb6c2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Column(
                    children: const [
                      Icon(Icons.share),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '分享',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffadb6c2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 52,
                  height: 52,
                  child: Column(
                    children: const [
                      Icon(Icons.warning_amber_rounded),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '举报',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffadb6c2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
