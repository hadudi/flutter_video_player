class VodDetailData {
  VodDetailData({
    this.apiData,
  });

  final ApiData? apiData;

  factory VodDetailData.fromJson(
    Map<String, dynamic> json,
  ) =>
      VodDetailData(
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

  factory ApiData.fromJson(
    Map<String, dynamic> json,
  ) =>
      ApiData(
        curVideoMeta: CurVideoMeta.fromJson(
          json["curVideoMeta"],
        ),
        longVideoSideBar: LongVideoSideBar.fromJson(
          json["longVideoSideBar"],
        ),
      );
}

class CurVideoMeta {
  CurVideoMeta({
    this.id,
    this.title,
    this.poster,
    this.playurl,
    this.clarityUrl,
    this.dramaInfo,
    // this.videoInfo,
  });

  final String? id;
  final String? title;
  final String? poster;
  final String? playurl; //默认播放地址， 可以取clarityUrl第一个
  final List<ClarityUrl>? clarityUrl; //清晰度
  final DramaInfo? dramaInfo;
  // final VideoInfo? videoInfo;

  factory CurVideoMeta.fromJson(Map<String, dynamic> json) => CurVideoMeta(
        id: json["id"],
        title: json["title"],
        poster: json["poster"],
        playurl: json["playurl"],
        clarityUrl: List<ClarityUrl>.from(
          json["clarityUrl"].map(
            (x) => ClarityUrl.fromJson(x),
          ),
        ),
        dramaInfo: DramaInfo.fromJson(json["dramaInfo"]),
      );
}

///当前播放信息模型
class ClarityUrl {
  ClarityUrl({
    this.title,
    this.url,
    this.videoSize,
  });

  final String? title; //清晰度名称
  final String? url; //播放地址
  final int? videoSize; //视频大小

  factory ClarityUrl.fromJson(
    Map<String, dynamic> json,
  ) =>
      ClarityUrl(
        title: json["title"],
        url: json["url"],
        videoSize: json["videoSize"],
      );
}

/// 影视信息模型
class DramaInfo {
  DramaInfo({
    this.videoName,
    this.seriesNum,
    this.verticalImage,
    this.sumPlayCnt,
    this.typeName,
    this.introduction,
    this.currentNum,
    this.isFinish,
  });

  final String? videoName;
  final String? seriesNum;
  final String? verticalImage;
  final String? sumPlayCnt;
  final String? typeName;
  final String? introduction;
  final String? currentNum;
  final String? isFinish;

  factory DramaInfo.fromJson(Map<String, dynamic> json) => DramaInfo(
        videoName: json["videoName"],
        seriesNum: json["seriesNum"],
        verticalImage: json["verticalImage"],
        sumPlayCnt: json["sumPlayCnt"],
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

  factory LongVideoSideBar.fromJson(
    Map<String, dynamic> json,
  ) =>
      LongVideoSideBar(
        episodes: List<Episode>.from(
          json["episodes"].map(
            (x) => Episode.fromJson(x),
          ),
        ),
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

// class CollectionInfo {
//   String title;
//   String collectionId;
//   List<VideoInfo> videoInfo;

//   CollectionInfo({this.title, this.collectionId, this.videoInfo});

//   CollectionInfo.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     collectionId = json['collection_id'];
//     if (json['video_info'] != null) {
//       videoInfo = new List<VideoInfo>();
//       json['video_info'].forEach((v) {
//         videoInfo.add(new VideoInfo.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['collection_id'] = this.collectionId;
//     if (this.videoInfo != null) {
//       data['video_info'] = this.videoInfo.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VideoInfo {
//   String title;
//   String vid;
//   String coverSrc;

//   VideoInfo({this.title, this.vid, this.coverSrc});

//   VideoInfo.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     vid = json['vid'];
//     coverSrc = json['cover_src'];
//   }
// }

// class Rec {
//   String cover;
//   String horizontalCover;
//   String title;
//   String episodesNum;
//   String firstEpisodes;
//   String introduction;
//   String sumPlayCnt;
//   String authorName;

//   Rec(
//       {this.cover,
//       this.horizontalCover,
//       this.title,
//       this.episodesNum,
//       this.firstEpisodes,
//       this.introduction,
//       this.sumPlayCnt,
//       this.authorName});

//   Rec.fromJson(Map<String, dynamic> json) {
//     cover = json['cover'];
//     horizontalCover = json['horizontalCover'];
//     title = json['title'];
//     episodesNum = json['episodesNum'];
//     firstEpisodes = json['firstEpisodes'];
//     introduction = json['introduction'];
//     sumPlayCnt = json['sumPlayCnt'];
//     authorName = json['authorName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cover'] = this.cover;
//     data['horizontalCover'] = this.horizontalCover;
//     data['title'] = this.title;
//     data['episodesNum'] = this.episodesNum;
//     data['firstEpisodes'] = this.firstEpisodes;
//     data['introduction'] = this.introduction;
//     data['sumPlayCnt'] = this.sumPlayCnt;
//     data['authorName'] = this.authorName;
//     return data;
//   }
// }
