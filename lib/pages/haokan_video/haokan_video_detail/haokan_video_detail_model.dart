class Data {
  Data({
    this.apiData,
  });

  final ApiData? apiData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        apiData: ApiData.fromJson(json["apiData"]),
      );
}

class ApiData {
  ApiData({
    this.curVideoMeta,
    this.longVideoSideBar,
  });

  final CurVideoMeta? curVideoMeta;
  final LongVideoSideBar? longVideoSideBar;

  factory ApiData.fromJson(Map<String, dynamic> json) => ApiData(
        curVideoMeta: CurVideoMeta.fromJson(json["curVideoMeta"]),
        longVideoSideBar: LongVideoSideBar.fromJson(json["longVideoSideBar"]),
      );
}

class CurVideoMeta {
  CurVideoMeta({
    this.id,
    this.title,
    this.poster,
    this.fmplaycnt,
    this.date,
    this.timeLength,
    this.duration,
    this.playurl,
    this.clarityUrl,
    this.isLongVideo,
    this.dramaInfo,
    this.allowPlay,
  });

  final String? id;
  final String? title;
  final String? poster;
  final String? fmplaycnt;
  final String? date;
  final String? timeLength;
  final int? duration;
  final String? playurl;
  final List<ClarityUrl>? clarityUrl;
  final bool? isLongVideo;
  final DramaInfo? dramaInfo;
  final int? allowPlay;

  factory CurVideoMeta.fromJson(Map<String, dynamic> json) => CurVideoMeta(
        id: json["id"],
        title: json["title"],
        poster: json["poster"],
        fmplaycnt: json["fmplaycnt"],
        date: json["date"],
        timeLength: json["time_length"],
        duration: json["duration"],
        playurl: json["playurl"],
        clarityUrl: List<ClarityUrl>.from(
            json["clarityUrl"].map((x) => ClarityUrl.fromJson(x))),
        isLongVideo: json["isLongVideo"],
        dramaInfo: DramaInfo.fromJson(json["dramaInfo"]),
        allowPlay: json["allow_play"],
      );
}

///当前播放信息模型
class ClarityUrl {
  ClarityUrl({
    this.key,
    this.rank,
    this.title,
    this.url,
    this.videoBps,
    this.vodVideoHw,
    this.videoSize,
    this.vodMoovSize,
    this.codecType,
  });

  final String? key;
  final int? rank;
  final String? title;
  final String? url;
  final int? videoBps;
  final String? vodVideoHw;
  final int? videoSize;
  final int? vodMoovSize;
  final String? codecType;

  factory ClarityUrl.fromJson(Map<String, dynamic> json) => ClarityUrl(
        key: json["key"],
        rank: json["rank"],
        title: json["title"],
        url: json["url"],
        videoBps: json["videoBps"],
        vodVideoHw: json["vodVideoHW"],
        videoSize: json["videoSize"],
        vodMoovSize: json["vodMoovSize"],
        codecType: json["codec_type"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "rank": rank,
        "title": title,
        "url": url,
        "videoBps": videoBps,
        "vodVideoHW": vodVideoHw,
        "videoSize": videoSize,
        "vodMoovSize": vodMoovSize,
        "codec_type": codecType,
      };
}

/// 影视信息模型
class DramaInfo {
  DramaInfo({
    this.videoName,
    this.seriesNum,
    this.verticalImage,
    this.sumPlayCnt,
    this.typeValue,
    this.typeName,
    this.introduction,
    this.currentNum,
    this.isFinish,
  });

  final String? videoName;
  final String? seriesNum;
  final String? verticalImage;
  final String? sumPlayCnt;
  final String? typeValue;
  final String? typeName;
  final String? introduction;
  final String? currentNum;
  final String? isFinish;

  factory DramaInfo.fromJson(Map<String, dynamic> json) => DramaInfo(
        videoName: json["videoName"],
        seriesNum: json["seriesNum"],
        verticalImage: json["verticalImage"],
        sumPlayCnt: json["sumPlayCnt"],
        typeValue: json["typeValue"],
        typeName: json["typeName"],
        introduction: json["introduction"],
        currentNum: json["currentNum"],
        isFinish: json["isFinish"],
      );
}

///选集信息模型
class LongVideoSideBar {
  LongVideoSideBar({
    required this.episodes,
  });

  final List<Episode> episodes;

  factory LongVideoSideBar.fromJson(Map<String, dynamic> json) =>
      LongVideoSideBar(
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );
}

///集信息模型
class Episode {
  Episode({
    this.no,
    this.vid,
  });

  final String? no;
  final String? vid;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        no: json["no"],
        vid: json["vid"],
      );
}
