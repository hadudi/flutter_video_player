import 'package:flutter_video_player/database/hv_manager.dart';

import 'user_info_model.dart';

class UserManger {
  UserManger._();

  static final UserManger _instance = UserManger._();
  static UserManger get instance => _instance;
  factory UserManger() => _instance;

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set setIsLogin(bool value) {
    _isLogin = value;
    if (!value) {
      UserManger.instance.userModel = null;
    }
  }

  UserInfoModel? userModel;

  getLocalLogin() async {
    UserInfoModel? model = await getUserInfo();
    setIsLogin = model != null;
    userModel = model;
  }

  ///保存用户信息
  static Future<bool> saveUserInfo(UserInfoModel model) async {
    UserManger.instance.setIsLogin = true;
    UserManger.instance.userModel = model;
    return HiveManager().saveUserInfo(model);
  }

  /// 获取用户信息
  static Future<UserInfoModel?> getUserInfo() async {
    return await HiveManager().getUserInfo();
  }

  /// 删除用户信息
  static Future<bool> deleteUserInfo() async {
    UserManger.instance.setIsLogin = false;
    return await HiveManager().deleteUserInfo();
  }

  /// 退出登录
  logout() async {
    UserInfoModel? model = await getUserInfo();
    if (model == null || model.token == null) {
      return;
    }
    await deleteUserInfo();
  }
}
