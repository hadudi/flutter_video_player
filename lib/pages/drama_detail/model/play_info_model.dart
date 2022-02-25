import 'video_info_model.dart';

class PlayInfoModel {
  PlayInfo? playInfo;
  List<Quality>? qualityList;
  Quality? currentQuality;

  PlayInfoModel.fromJson(Map<String, dynamic> json) {
    playInfo = PlayInfo.fromJson(json['playInfo']);
    try {
      qualityList =
          (((json['qualityList'] is List ? json['qualityList'] : []) as List)
              .map((e) => Quality.fromJson(e))).toList();
      if (qualityList?.isNotEmpty == true) {
        currentQuality =
            qualityList?.firstWhere((element) => element.quality == 'LD');
      }
    } catch (e) {
      // (e);
    }
  }
}

class Quality {
  Quality({
    this.quality,
    this.qualityName,
    this.vipFlag,
    this.qualityShortName,
    this.qualityCode,
    this.qualityDescription,
  });

  String? quality;
  String? qualityName;
  bool? vipFlag;
  String? qualityDescription;
  String? qualityShortName;
  String? qualityCode;

  factory Quality.fromJson(Map<String, dynamic> json) {
    return Quality(
      vipFlag: json["vipFlag"],
      qualityDescription: json["qualityDescription"],
      quality: json["quality"],
      qualityName: json["qualityName"],
      qualityShortName: json["qualityShortName"],
      qualityCode: json["qualityCode"],
    );
  }
}
