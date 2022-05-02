import 'package:flutter_video_player/abstracts/abstract_interface.dart';
import 'package:flutter_video_player/http/http_config.dart';
import 'package:flutter_video_player/http/http_response_model.dart';

import '../model/home_model.dart';

class HomeViewModel implements Request {
  late List<HomePageModel> pageModelList = [];

  @override
  Future<BigEyeModel?> handleData(ResponseModel data) async {
    var model = HomeDataModel.fromJson(data.map);
    pageModelList.clear();
    if (model.top != null) {
      BannerTop top = model.top!;
      if (top.eyeList?.isNotEmpty == true) {
        pageModelList.add(
          HomePageModel(
            type: SectionType.bigEye,
            itemArray: top.eyeList!,
          ),
        );
      }
      if (top.guideList != null) {
        pageModelList.add(
          HomePageModel(
            type: SectionType.guide,
            itemArray: top.guideList!,
          ),
        );
      }
    }
    if (model.sections != null) {
      model.sections?.forEach(
        (e) {
          if (e.sectionContents?.isEmpty == true) {
            return;
          }
          if (e.sectionType == 'SINGLE_IMAGE') {
            pageModelList.add(HomePageModel(
              type: SectionType.singleImage,
              itemArray: e.sectionContents ?? [],
              title: e.name ?? '',
              redirectUrl: e.targetId,
            ));
          } else if (e.sectionType == 'VIDEO' ||
              e.sectionType == 'VIDEO_AUTO') {
            pageModelList.add(HomePageModel(
              type: SectionType.mutilEntry,
              itemArray: e.sectionContents ?? [],
              title: e.name ?? '',
              redirectUrl: e.targetId,
            ));
          }
        },
      );
    }
    return model.top?.eyeList?.first;
  }

  @override
  Future<BigEyeModel?> requestData({
    int pageNum = 1,
    Map<String, dynamic> queryParams = const {},
  }) async {
    ResponseModel? model = await HttpConfig.request(api: Api.home);
    if (model != null) {
      return await handleData(model);
    }
    return null;
  }
}
