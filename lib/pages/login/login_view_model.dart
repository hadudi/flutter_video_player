import 'package:flutter_video_player/http/http_config.dart';
import 'package:flutter_video_player/http/http_response_model.dart';
import 'package:flutter_video_player/user/user_info_model.dart';
import 'package:flutter_video_player/user/user_manager.dart';

class LoginViewModel {
  ///发送验证码
  Future<bool> sendVerifyCode(String mobile) async {
    ResponseModel? data = await HttpConfig.request(
      api: Api.sendVerifyCode,
      queryParams: {
        'mobile': mobile,
        'countryCode': '+86',
      },
    );
    return data?.code == '0000';
  }

  /* 验证码登录 */
  Future<bool> verifyCodeLogin(String mobile, String code) async {
    ResponseModel? data = await HttpConfig.request(
      api: Api.verifyCodeLogin,
      queryParams: {
        'mobile': mobile,
        'captchaSms': code,
        'countryCode': '+86',
      },
    );
    if (data != null) {
      UserInfoModel model = UserInfoModel.fromJson(data.map);
      bool saved = await UserManger.saveUserInfo(model);
      return data.code == '0000' && saved;
    }
    return false;
  }
}
