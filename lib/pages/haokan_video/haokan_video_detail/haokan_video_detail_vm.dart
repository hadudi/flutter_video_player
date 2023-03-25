import 'package:flutter_video_player/http/http_manager.dart';

import 'haokan_video_detail_model.dart';

class DramaDetailViewModel {
  VodDetailData? videoInfoModel;

  /// 请求剧集信息
  Future<VodDetailData?> requestData({
    required String dramaId,
  }) async {
    if (dramaId.length > 5) {
      ResponseCallBack? data = await HttpManager.request(
        req: NetApi.haokanDramaDetail,
        queryParams: {
          'vid': dramaId,
          '_format': 'json',
        },
      );
      if (data.model != null) {
        videoInfoModel = VodDetailData.fromJson(data.model!.map);
      }
    }
    return videoInfoModel;
  }
}
