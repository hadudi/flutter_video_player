class VideoInfoModel {
  List<Series>? seriesList;
  List<Episode>? episodeList;
  DramaInfo? drama;
  PlayInfo? playInfo;

  Series? currentSeries;
  Episode? currentEpisode;
  Episode? nextEpisode;

  VideoInfoModel.fromJson(Map<String, dynamic> json) {
    drama = DramaInfo.fromJson(json['drama']);
    playInfo = PlayInfo.fromJson(json['playInfo']);
    try {
      episodeList =
          (((json['episodeList'] is List ? json['episodeList'] : []) as List)
              .map((e) => Episode.fromJson(e))).toList();
      seriesList =
          (((json['seriesList'] is List ? json['seriesList'] : []) as List)
              .map((e) => Series.fromJson(e))).toList();

      if (seriesList?.isNotEmpty == true) {
        currentSeries = seriesList?.first;
      }
      if (episodeList?.isNotEmpty == true) {
        currentEpisode = episodeList?.firstWhere(
            (element) => element.episodeSid == playInfo?.episodeSid);
      }
    } catch (e) {
      //(e);
    }
  }
}

class DramaInfo {
  DramaInfo({
    this.id,
    this.createTime,
    this.title,
    this.cover,
    this.brief,
    this.score,
    this.year,
    this.area,
    this.enName,
    this.cat,
    this.dramaType,
    this.serializedStatus,
    this.episodeCount,
  });

  int? id;
  String? createTime;
  String? title;
  String? cover;
  String? brief;
  double? score;
  String? year;
  String? area;
  String? enName;
  String? cat;
  String? dramaType;
  String? serializedStatus;
  int? episodeCount;

  String get info => '$dramaType/$year/$area/$cat';

  factory DramaInfo.fromJson(Map<String, dynamic> json) => DramaInfo(
        id: json["id"],
        createTime: json["createTime"],
        title: json["title"],
        cover: json["cover"],
        brief: json["brief"],
        score: json["score"].toDouble(),
        year: json["year"],
        area: json["area"],
        enName: json["enName"],
        cat: json["cat"],
        dramaType: json["dramaType"],
        serializedStatus: json["serializedStatus"],
        episodeCount: json["episodeCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createTime": createTime,
        "title": title,
        "cover": cover,
        "brief": brief,
        "score": score,
        "year": year,
        "area": area,
        "enName": enName,
        "cat": cat,
        "dramaType": dramaType,
        "serializedStatus": serializedStatus,
        "episodeCount": episodeCount,
      };
}

class Series {
  Series({
    this.dramaId,
    this.seasonNo,
    this.relatedName,
    this.id,
  });

  int? dramaId;
  int? seasonNo;
  String? relatedName;
  int? id;

  bool isSelected = false;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        dramaId: json["dramaId"],
        seasonNo: json["seasonNo"],
        relatedName: json["relatedName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dramaId": dramaId,
        "seasonNo": seasonNo,
        "relatedName": relatedName,
        "id": id,
      };
}

class Episode {
  Episode({
    this.episodeNo,
    this.text,
    this.episodeSid,
  });

  int? episodeNo;
  String? text;
  int? episodeSid;
  bool isSelected = false;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        episodeNo: json["episodeNo"],
        text: json["text"],
        episodeSid: json["episodeSid"],
      );

  Map<String, dynamic> toJson() => {
        "episodeNo": episodeNo,
        "text": text,
        "episodeSid": episodeSid,
      };
}

class PlayInfo {
  PlayInfo({
    this.mediaId,
    this.episodeSid,
    this.url,
    this.startingLength,
    this.currentQuality,
  });

  int? mediaId;
  int? episodeSid;
  String? url;
  String? currentQuality;
  int? startingLength;

  factory PlayInfo.fromJson(Map<String, dynamic> json) {
    return PlayInfo(
      url: json["url"],
      currentQuality: json["currentQuality"],
      mediaId: json["mediaId"],
      episodeSid: json["episodeSid"],
      startingLength: json["startingLength"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "currentQuality": currentQuality,
        "mediaId": mediaId,
        "episodeSid": episodeSid,
        "startingLength": startingLength,
      };
}
