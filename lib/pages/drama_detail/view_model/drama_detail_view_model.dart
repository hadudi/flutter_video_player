import 'package:flutter_video_player/http/http_config.dart';
import 'package:flutter_video_player/http/http_manager.dart';
import 'package:flutter_video_player/http/http_response_model.dart';
import 'package:flutter_video_player/pages/drama_detail/model/play_info_model.dart';
import 'package:flutter_video_player/pages/drama_detail/model/video_info_model.dart';

class DramaDetailViewModel {
  VideoInfoModel? videoInfoModel;
  PlayInfoModel? playInfoModel;

  /// 请求剧集信息
  Future<VideoInfoModel?> requestData({required String dramaId}) async {
    // if (dramaId.length > 10) {
    //   ResponseCallBack? data = await HttpManager.request(req: NetApi.haokanDramaDetail, queryParams: {
    //     'vid': dramaId,
    //     '_format': 'json',
    //   },);
    //   if (data.model != null) {

    //   }
    // }
    ResponseModel? model = await HttpConfig.request(api: Api.dramaDetail);
    if (model != null) {
      videoInfoModel = VideoInfoModel.fromJson(model.map);
    }
    return videoInfoModel;
  }

  /// 请求播放数据
  Future<PlayInfoModel?> requestPlayInfo({
    required String? dramaId,
    required int? episodeId,
    String? quality = 'LD',
  }) async {
    ResponseModel? model =
        await HttpConfig.request(api: Api.dramaPlay, queryParams: {
      'dramaId': dramaId,
      'episodeId': '${episodeId! - 10000}',
    });
    if (model != null) {
      playInfoModel = PlayInfoModel.fromJson(model.map);
    }

    videoInfoModel?.currentEpisode = videoInfoModel?.episodeList?.firstWhere(
        (element) => element.episodeSid == playInfoModel?.playInfo?.episodeSid);

    int index = videoInfoModel?.episodeList?.indexWhere((element) =>
            element.episodeSid == videoInfoModel?.currentEpisode?.episodeSid) ??
        0;
    if (videoInfoModel?.currentEpisode != null &&
        (index + 1) < (videoInfoModel?.episodeList?.length ?? 0)) {
      videoInfoModel?.nextEpisode = videoInfoModel?.episodeList?[index + 1];
    } else {
      videoInfoModel?.nextEpisode = null;
    }

    return playInfoModel;
  }

  @override
  bool operator ==(Object other) {
    if (other is DramaDetailViewModel) {
      return false;
    }
    return false;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
