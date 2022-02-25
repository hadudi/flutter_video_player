import 'package:flutter_video_player/http/http_config.dart';
import 'package:flutter_video_player/http/http_response_model.dart';
import 'package:flutter_video_player/pages/home/model/home_model.dart';

import '../model/category_model.dart';

class CategoryViewModel {
  List<AllCategoriesGroupModel> groupArray = [];
  List<SectionContentModel> contentArray = [];
  Map filterParams = {};

  String get filterTitle {
    var str0 = '';
    var str1 = '';
    var str2 = '';

    for (var item in groupArray) {
      var sectionType = item.groupType;
      var model = item.itemArray[item.groupIndex];
      if (sectionType == 'sort') {
        str1 = model.title;
      } else if (sectionType == 'area') {
        str0 = model.title;
      } else if (sectionType == 'plotType') {
        str2 = model.title;
      }
    }

    var title = '';
    if (str0 == '') {
      title = '$str1 · $str2';
    } else {
      title = '$str0 · $str1 · $str2';
    }
    return title;
  }

  /// 获取分类相关筛选项
  Future<void> fetchCategory() async {
    ResponseModel? model = await HttpConfig.request(api: Api.categoryHeader);
    if (model != null) {
      groupArray = model.list
          .map(
            (e) => AllCategoriesGroupModel.fromJson(e),
          )
          .toList();
    }
  }

  /// 获取筛选搜索结果
  Future fetchCategoryContent({int page = 1}) async {
    ResponseModel? model =
        await HttpConfig.request(api: Api.categoryPage, queryParams: {
      'page': page,
    });
    if (model != null) {
      contentArray =
          model.list.map((e) => SectionContentModel.fromJson(e)).toList();
    }
  }
}
