import '../../abstracts/abstract_interface.dart';
import 'bilibili_model.dart';
import '../../http/http_manager.dart';
import '../../http/http_response_model.dart';

class HotVideoViewModel implements Request {
  late List<RecommendModel> pageModelList = [];

  int pageNumber = 0;

  @override
  Future<List<RecommendModel>> handleData(ResponseModel data) async {
    pageModelList.clear();
    List items = data.map['items'];
    pageModelList.addAll(items.map((e) => RecommendModel.fromJson(e)));
    return pageModelList;
  }

  @override
  Future requestData({
    int pageNum = 0,
    Map<String, dynamic> queryParams = const {},
  }) async {
    ResponseCallBack data = await HttpManager.request(
      req: NetApi.bilibiliHotVideo,
      queryParams: {
        'page_size': 20,
        'page_num': pageNum,
        'type': 'recommend',
      },
    );
    pageNumber = pageNum + 1;

    if (pageNum == 0) {
      pageModelList.clear();
    }

    if (data.model == null) {
      return [];
    }

    List items = data.model!.map['items'];
    pageModelList.addAll(items.map((e) => RecommendModel.fromJson(e)));
  }
}
