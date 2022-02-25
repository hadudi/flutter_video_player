import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/drama_detail/model/video_info_model.dart';
import 'package:flutter_video_player/pages/drama_detail/page/drama_detail_page.dart';
import 'package:flutter_video_player/uitl/r_sources.dart';

typedef SwitchEpisodeCallback = Function(int? episodeId);

class VideoSeriesView extends StatefulWidget {
  const VideoSeriesView({
    Key? key,
    required this.switchEpisodeCallback,
  }) : super(key: key);

  final SwitchEpisodeCallback? switchEpisodeCallback;

  @override
  _VideoSeriesViewState createState() => _VideoSeriesViewState();
}

class _VideoSeriesViewState extends State<VideoSeriesView> {
  VideoInfoModel? get model =>
      DramaPlayInfoWidget.of(context)?.viewModel.videoInfoModel;

  @override
  Widget build(BuildContext context) {
    var serializedStatus = model?.drama?.serializedStatus?.isNotEmpty == true
        ? model?.drama?.serializedStatus
        : '未开播';
    return Container(
      margin: const EdgeInsets.only(top: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            padding: const EdgeInsets.only(
              top: 8,
              left: 6,
              right: 6,
            ),
            child: (model?.seriesList?.length ?? 0) < 2
                ? Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      model?.drama?.dramaType == 'MOVIE' ? '专辑' : '选集',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff32383a),
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model?.seriesList?.length ?? 0,
                    itemBuilder: (context, index) {
                      Series? series = model?.seriesList?[index];
                      series?.isSelected = (series.dramaId == model?.drama?.id);
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '${series?.relatedName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: series?.isSelected == true
                                  ? const Color(0xff32383a)
                                  : const Color(0xffadb6c2),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            model?.currentSeries = model?.seriesList?[index];
                          });
                        },
                      );
                    },
                  ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 10, 8),
                child: Text(
                  serializedStatus ?? '',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xffadb6c2),
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: (model?.episodeList?.length ?? 0) > 2,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(right: 12),
                    width: 72,
                    height: 28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '全部剧集',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
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
                    Navigator.pushNamed(context, '/explosid');
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 54,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              scrollDirection: Axis.horizontal,
              itemCount: model?.episodeList?.length ?? 0,
              itemBuilder: (context, index) {
                Episode? episode = model?.episodeList?[index];
                bool hasText = (episode?.text?.length ?? 0) > 0;
                String? text =
                    hasText ? episode?.text : '${episode?.episodeNo}';
                episode?.isSelected =
                    (model?.currentEpisode?.episodeSid == episode.episodeSid);
                return GestureDetector(
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 54,
                      minHeight: 54,
                    ),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: hasText
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f6f8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: (!hasText && episode?.isSelected == true)
                        ? Image.asset(R.Img.ic_playing)
                        : Text(
                            '$text',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: episode?.isSelected == true
                                  ? const Color(0xffFB6060)
                                  : const Color(0xff3b4051),
                            ),
                          ),
                  ),
                  onTap: () {
                    setState(() {
                      model?.currentEpisode = model?.episodeList?[index];
                    });
                    widget.switchEpisodeCallback
                        ?.call(model?.currentEpisode?.episodeSid);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
