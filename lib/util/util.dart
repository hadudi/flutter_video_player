import 'package:flutter/material.dart';

class Util {
  Util._();

  static final Util _instance = Util._();
  static Util get instance => _instance;
  factory Util() => _instance;

  ///  屏幕像素倍数
  static final double _devicePixelRatio =
      WidgetsBinding.instance.window.devicePixelRatio;

  /// 屏幕物理像素大小
  static Size get _size =>
      WidgetsBinding.instance.window.physicalSize / _devicePixelRatio;

  static bool get isPhoneX => WidgetsBinding.instance.window.padding.top > 60;

  /// 图片宽高比
  static const imgRatio = 0.75;

  /// banner的图片比例
  static const bigEyeImgRatio = 351.0 / 468.0;

  ///  状态栏高度,44 : 20, 部分X机型上,高度会判断为47，这里写死
  static double get statusBarHeight => isPhoneX ? 44 : 20;

  /// 导航条高度 44
  static const double navBarHeight = 44;

  /// 导航栏整体高度
  static double get navgationBarHeight => statusBarHeight + 44;

  /// 底部导航栏高度 83 : 49
  static double get tabBarHeight => isPhoneX ? 83 : 49;

  /// 屏幕宽度
  static double get appWidth => _size.width;

  /// 屏幕高度
  static double get appHeight => _size.height;

  static bool isMobile(String mobile) {
    if (mobile.isEmpty || mobile.length != 11) {
      return false;
    }
    const reg = r'^1[0-9]\d{9}$';
    return RegExp(reg).hasMatch(mobile);
  }

  static bool isVerifyCode(String code) {
    if (code.isEmpty || code.length != 6) {
      return false;
    }
    const reg = r'\d{6}$';
    return RegExp(reg).hasMatch(code);
  }
}
