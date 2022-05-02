import 'package:flutter_video_player/http/http_response_model.dart';

import '../../abstracts/abstract_interface.dart';
import 'haokan_home_model.dart';
import '../../http/http_manager.dart';

class HaoKanHomeViewModel implements Request {
  late List<DramaItemModel> pageModelList = [];

  int pageNumber = 1;

  @override
  Future requestData({
    int pageNum = 1,
    Map<String, dynamic> queryParams = const {},
  }) async {
    ResponseCallBack data = await HttpManager.request(
      req: NetApi.haokanHome,
      queryParams: {
        'rn': 20,
        'pn': pageNum,
        'type': '0',
      },
    );
    pageNumber++;

    if (pageNum == 1) {
      pageModelList.clear();
    }

    if (data.model == null) {
      return [];
    }

    HomeResponseModel resModel = HomeResponseModel.fromJson(data.model!.map['response']);
    pageModelList.addAll(resModel.pageData ?? []);
  }

  @override
  Future handleData(ResponseModel model) {
    throw UnimplementedError();
  }
}
