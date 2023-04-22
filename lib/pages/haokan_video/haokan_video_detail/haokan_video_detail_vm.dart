import 'package:flutter_video_player/http/http_manager.dart';

import 'haokan_video_detail_model.dart';

class VodDetailViewModel {
  VodDetailModel? vodDetailModel;

  /// 请求剧集信息
  Future<VodDetailModel?> requestData({
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
        return VodDetailModel.fromJson(data.model!.map);
      }
    }
    return null;
  }
}
