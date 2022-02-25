import 'package:package_info_plus/package_info_plus.dart';

class Device {
  static late final PackageInfo info;
  static final Device _instance = Device._();
  static Device get instance => _instance;

  Device._() {
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    info = await PackageInfo.fromPlatform();
  }
}
