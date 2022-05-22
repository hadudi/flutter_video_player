import 'haokan_home_model.dart';
import '../../http/http_manager.dart';

enum DramaType {
  ///全部
  all(0, '全部'),

  ///古装剧
  costume(1, '古装剧'),

  ///家庭剧
  family(2, '家庭剧'),

  ///爱情剧
  love(3, '爱情剧'),

  ///悬疑剧
  crux(4, '悬疑剧'),

  ///武侠剧
  kungfu(5, '武侠剧'),

  ///喜剧
  comedy(6, '喜剧'),

  ///战争剧
  war(7, '战争剧');

  final int value;
  final String name;

  const DramaType(this.value, this.name);
}

class HaoKanHomeViewModel {
  late List<DramaItemModel> pageModelList = [];

  int pageNumber = 1;

  Future requestData({
    required DramaType type,
    int pageNum = 1,
  }) async {
    ResponseCallBack data = await HttpManager.request(
      req: NetApi.haokanHome,
      queryParams: {
        'rn': 20,
        'pn': pageNum,
        'type': type.value,
      },
    );
    pageNumber = pageNum + 1;

    if (pageNum == 1) {
      pageModelList.clear();
    }

    if (data.model == null) {
      return [];
    }

    HomeResponseModel resModel =
        HomeResponseModel.fromJson(data.model!.map['response']);
    pageModelList.addAll(resModel.pageData ?? []);
  }
}
