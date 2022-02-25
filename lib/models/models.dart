// 页面传递数据，临时用的
class DramaCoverModel {
  String? dramaId;
  String? coverUrl;

  DramaCoverModel({required this.dramaId, this.coverUrl});
}

class DramaPageModel {
  DramaModel? drama;
}

class DramaModel {
  int? dramaId;
  int? seasonNo;
  String? area;
  String? brief;
  String? cover;
  String? cat;
  String? createTime;
  String? enName;
  String? relatedName;
  bool? vipFlag;
  double? score;
  String? title;
  String? updateTime;
  String? year;
  String? serializedStatus;
  String? serializedTips;
  String? dramaType;
  String? catString;
  bool? dramaMovie;

  String? dramaInfo;
  String? dramaTypeStr;

  DramaModel.fromJsom(Map map) : dramaId = map['dramaId'];
}
