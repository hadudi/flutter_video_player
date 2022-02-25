import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserInfoModel extends HiveObject {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  String? nickName;

  @HiveField(2)
  String? mobile;

  @HiveField(3)
  String? token;

  // 网络数据，完整数据
  UserInfoModel.fromJson(Map map) {
    if (map.isEmpty) {
      return;
    }
    Map user = map['user'];
    userId = user['userId'];
    nickName = user['nickName'];
    mobile = user['mobile'];
    token = map['token'];
  }

  // 本地数据, 简化数据
  UserInfoModel(Map user) {
    userId = user['userId'];
    nickName = user['nickName'];
    mobile = user['mobile'];
    token = user['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickName': nickName,
      'mobile': mobile,
      'token': token,
    };
  }
}

class UserInfoAdapter extends TypeAdapter<UserInfoModel> {
  @override
  final typeId = 0;

  @override
  UserInfoModel read(BinaryReader reader) {
    dynamic va = reader.read(typeId);
    if (va is Map && va.isNotEmpty) {
      return UserInfoModel(va);
    }

    return UserInfoModel({});
  }

  @override
  void write(BinaryWriter writer, UserInfoModel obj) {
    writer.write(obj.userId);
    writer.write(obj.nickName);
    writer.write(obj.mobile);
    writer.write(obj.token);
  }
}
