import '../../../http/http_manager.dart';
import 'haokan_short_video_model.dart';

class HaoKanShortVideoViewModel {
  late List<ShortVideoItem> videoList = [];

  int pageNumber = 1;

  // https://haokan.baidu.com/web/video/feed?tab=yingshi_new&act=pcFeed&pd=pc&num=20&shuaxin_id=9653361786441
  Future requestData({
    int pageNum = 1,
  }) async {
    ResponseCallBack data = await HttpManager.request(
      req: NetApi.haokanShortVideoList,
      queryParams: {
        'tab': 'recommend',
        'act': 'pcFeed',
        'pd': 'pc',
        'num': 10,
      },
    );
    pageNumber = pageNum + 1;
    if (pageNum == 1) {
      videoList.clear();
    }

    if (data.model == null) {
      return [];
    }

    // HaoKanShortVideoModel resModel =
    //     HaoKanShortVideoModel.fromJson(data.model!.map['response']);
    // videoList.addAll(resModel.videos ?? []);
  }
}
