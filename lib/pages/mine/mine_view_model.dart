import 'package:flutter_video_player/abstracts/abstract_interface.dart';
import 'package:flutter_video_player/http/http_config.dart';
import 'package:flutter_video_player/http/http_response_model.dart';
import 'package:flutter_video_player/pages/home/model/home_model.dart';
import 'package:flutter_video_player/user/user_manager.dart';
import 'package:flutter_video_player/util/r_sources.dart';

class MineViewModel implements Request {
  String get avatar {
    return UserManger.instance.isLogin
        ? R.Img.pic_Avatar_h
        : R.Img.pic_Avatar_n;
  }

  String get nickName {
    return UserManger.instance.isLogin
        ? (UserManger().userModel?.nickName ?? '')
        : '登录/注册';
  }

  String get phoneText {
    return UserManger.instance.isLogin
        ? (UserManger().userModel?.mobile ?? '00000000000')
            .replaceRange(3, 7, ' **** ')
        : '快来开启剧圈圈煲剧之旅';
  }

  late List<SectionContentModel> funcList;

  MineViewModel() {
    funcList = [];
  }

  @override
  Future handleData(ResponseModel data) async {
    var model = HomeDataModel.fromJson(data.map);
    funcList.clear();
    if (model.sections != null) {
      funcList = model.sections!.first.sectionContents ?? [];
    }
  }

  @override
  Future requestData({
    int pageNum = 1,
    Map<String, dynamic> queryParams = const {},
  }) async {
    ResponseModel? model = await HttpConfig.request(api: Api.mine);
    if (model != null) {
      await handleData(model);
    }
  }
}
