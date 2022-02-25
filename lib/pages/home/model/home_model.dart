enum SectionType {
  bigEye,
  guide,
  mutilEntry,
  singleImage,
}

class HomePageModel {
  ///cell类型
  SectionType? type;

  ///cell内容
  List<dynamic> itemArray;

  ///cell标题
  String title;

  String? redirectUrl;

  HomePageModel({
    required this.type,
    required this.itemArray,
    this.title = '',
    this.redirectUrl,
  });
}

class HomeDataModel {
  BannerTop? top;
  List<SectionModel>? sections;
  bool isEnd = false;

  HomeDataModel.fromJson(Map map) {
    if (map.isEmpty) {
      return;
    }
    if (map['top'] != null) {
      top = BannerTop.fromJson(map['top']);
    }
    if (map['isEnd'] != null) {
      isEnd = map['isEnd'];
    }

    sections =
        (map['sections'] as List).map((e) => SectionModel.fromJson(e)).toList();
  }
}

class BannerTop {
  List<BigEyeModel>? eyeList;
  List<GuideModel>? guideList;

  BannerTop.fromJson(Map map) {
    if (map.isEmpty) {
      return;
    }
    // [{id: 6800, name: 华灯初上 第一季, title: 小酒馆妈妈桑的爱恨情仇，谁杀了谁, imgUrl: http://img.juquanquanapp.com/img/img/20211224/o_bf0eba1ea4b1430f9a6f707889ad4ce4.jpg, targetUrl: 38331, type: season, sequence: 1, redirectUrl: jgjg.jqq://season?seasonId=38331&isMovie=false, position: jqq_eye, filmSubtitle: 好口碑高人气新剧, filmTitle: 华灯初上, filmScore: 8.1}]
    // [{id: 6642, name: 美丽的他, title: 自闭少年恋上清冷美少年, imgUrl: http://img.juquanquanapp.com/img/img/20211119/o_93bfe0455e8c4b79a369ed4a0ad427fb.jpg, targetUrl: 38242, type: season, sequence: 1, redirectUrl: jgjg.jqq://season?seasonId=38242&isMovie=false, position: jqq_eye, filmSubtitle: 深陷一见钟情, filmTitle: 美丽的他, filmScore: 8.8}]
// [{id: 6799, name: 那年，我们的夏天, title: 《魔女》再组CP，这颗糖我死磕到底, imgUrl: http://img.juquanquanapp.com/img/img/20211224/o_b4f33018f2bc4c74811988d5e3e5e1c4.jpg, targetUrl: 38217, type: season, sequence: 1, redirectUrl: jgjg.jqq://season?seasonId=38217&isMovie=false, position: jqq_eye, filmSubtitle: 崔宇植×金多美, filmTitle: 那年，我们, filmScore: 9.0}]
// [{id: 6802, name: 猎魔人 第二季, title: 杰洛特再度华丽回归！, imgUrl: http://img.juquanquanapp.com/img/img/20211224/o_30fd136b7d454780b29da16cbdf4d030.jpg, targetUrl: 38253, type: season, sequence: 1, redirectUrl: jgjg.jqq://season?seasonId=38253&isMovie=false, position: jqq_eye, filmSubtitle: 巫师, filmTitle: 猎魔人, filmScore: 8.3}]
    List guides = map['guide'];
    List<dynamic> eyes =
        map['eye'] + (guides.length <= 2 ? guides : guides.sublist(2));
    eyeList = eyes.map((e) => BigEyeModel.fromJson(e)).toList();
    guideList = (guides.map((e) => GuideModel.fromJson(e))).toList();
  }
}

class BigEyeModel {
  int? id;
  String? imgUrl;
  String? name;
  String? title;
  String? position;
  String? redirectUrl;
  String? type;
  String? targetUrl;
  String? filmSubtitle;
  String? filmTitle;

  BigEyeModel.fromJson(Map map)
      : id = map['id'],
        imgUrl = map['imgUrl'],
        name = map['name'],
        position = map['position'],
        redirectUrl = map['redirectUrl'],
        type = map['type'],
        title = map['title'],
        filmTitle = map['filmTitle'],
        filmSubtitle = map['filmSubtitle'];

  @override
  String toString() {
    return 'title:$title, subTitle:$title, filmTitle:$filmTitle, filmSubtitle:$filmSubtitle';
  }
}

class GuideModel {
  int? id;
  double? filmScore;
  String? filmSubtitle;
  String? filmTitle;
  String? imgUrl;
  String? name;
  String? position;
  String? redirectUrl;
  String? type;
  String? targetUrl;

  GuideModel.fromJson(Map map)
      : id = map['id'],
        imgUrl = map['imgUrl'],
        name = map['name'],
        position = map['position'],
        redirectUrl = map['redirectUrl'],
        type = map['type'],
        filmTitle = map['filmTitle'],
        filmSubtitle = map['filmSubtitle'],
        filmScore = map['filmScore'];
}

class SectionModel {
  String? moreText;
  String? name;
  int? position;
  List<SectionContentModel>? sectionContents;
  String? sectionType;
  int? sequence;
  String? targetId;

  SectionModel.fromJson(Map map) {
    moreText = map['moreText'];
    name = map['name'];
    position = map['position'];
    sectionType = map['sectionType'];
    sequence = map['sequence'];
    targetId = map['targetId'];

    sectionContents = (map['sectionContents'] as List)
        .map((e) => SectionContentModel.fromJson(e))
        .toList();
  }
}

class SectionContentModel {
  String? coverUrl;
  int? dramaId;
  String? dramaType;
  String? icon;
  double? score;
  String? subTitle;
  String? targetId;
  String? targetType;
  String? title;
  String? pictureHeight;
  String? pictureWidth;
  bool? vipFlag;

  SectionContentModel.fromJson(Map map) {
    coverUrl = map['coverUrl'];
    dramaId = map['dramaId'];
    dramaType = map['dramaType'];
    icon = map['icon'];
    score = double.tryParse('${map['score']}');
    subTitle = map['subTitle'];
    targetId = map['targetId'];
    targetType = map['targetType'];
    title = map['title'];
    pictureHeight = map['pictureHeight'];
    pictureWidth = map['pictureWidth'];
    vipFlag = map['vipFlag'];
  }
}
