
class HomeResponseModel {
    const HomeResponseModel({
        this.pageData,
        this.hasMore,
    });

    final List<DramaItemModel>? pageData;
    final int? hasMore;

    factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
        pageData: List<DramaItemModel>.from(json["page_data"].map((x) => DramaItemModel.fromJson(x))),
        hasMore: json["has_more"],
    );
}

class DramaItemModel {
    const DramaItemModel({
        this.videoName,
        this.verticalImage,
        this.seriesNum,
        this.introduction,
        this.firstEpisodes,
        this.sumPlayCnt,
        this.horizontalImage,
        this.isFinish,
        this.previewUrlHttp,
        this.sumPlayCntText,
    });

    final String? videoName;
    final String? verticalImage;
    final String? seriesNum;
    final String? introduction;
    final String? firstEpisodes;
    final String? sumPlayCnt;
    final String? horizontalImage;
    final String? isFinish;
    final String? previewUrlHttp;
    final String? sumPlayCntText;

    factory DramaItemModel.fromJson(Map<String, dynamic> json) => DramaItemModel(
        videoName: json["videoName"],
        verticalImage: json["verticalImage"],
        seriesNum: json["seriesNum"],
        introduction: json["introduction"],
        firstEpisodes: json["firstEpisodes"],
        sumPlayCnt: json["sumPlayCnt"],
        horizontalImage: json["horizontalImage"],
        isFinish: json["isFinish"],
        previewUrlHttp: json["previewUrlHttp"],
        sumPlayCntText: json["sumPlayCntText"],
    );
}
