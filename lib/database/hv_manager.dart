// ignore_for_file: empty_catches, control_flow_in_finally

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_video_player/user/user_info_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class HiveManager {
  HiveManager._();
  static final HiveManager _instance = HiveManager._();
  static HiveManager get instance => _instance;

  @protected
  factory HiveManager() => _instance;

  static var boxPath = '';
  final userBox = 'UserBox';
  final userInfo = 'UserInfo';

  static Future<void> initHive() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      boxPath = p.join(directory.path, 'JQQHive');
      await Hive.initFlutter(boxPath);
    } catch (e) {}
  }

  ///User
  Future<bool> saveUserInfo(UserInfoModel model) async {
    try {
      final box = await Hive.openBox(userBox);
      await box.put(userInfo, model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserInfoModel?> getUserInfo() async {
    try {
      final box = await Hive.openBox(userBox);
      if (box.isEmpty) {
        return null;
      }
      Map? map = await box.getAt(0);
      if (map != null) {
        UserInfoModel model = UserInfoModel(map);
        if (model.token != null) {
          return model;
        }
      }
    } catch (e) {}
    return null;
  }

  Future<bool> deleteUserInfo() async {
    try {
      final box = await Hive.openBox(userBox);
      await box.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  ////
  ///
  final homeBox = 'HomeBox';
  final homeKey = 'HomeKey';
  Future<bool> saveHomeData(UserInfoModel model) async {
    try {
      final box = await Hive.openBox(homeBox);
      await box.put(homeKey, model.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
