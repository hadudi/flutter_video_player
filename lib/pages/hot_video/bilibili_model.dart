class RecommendModel {
  RecommendModel({
    this.user,
    this.item,
  });

  final User? user;
  final Item? item;

  factory RecommendModel.fromJson(Map<String, dynamic> json) => RecommendModel(
        user: User.fromJson(json["user"]),
        item: Item.fromJson(json["item"]),
      );
}

class Item {
  Item({
    this.docId,
    this.posterUid,
    this.pictures,
    this.title,
    this.category,
    this.uploadTime,
    this.alreadyLiked,
    this.alreadyVoted,
  });

  final int? docId;
  final int? posterUid;
  final List<Picture>? pictures;
  final String? title;
  final String? category;
  final int? uploadTime;
  final int? alreadyLiked;
  final int? alreadyVoted;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        docId: json["doc_id"],
        posterUid: json["poster_uid"],
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        title: json["title"],
        category: json["category"],
        uploadTime: json["upload_time"],
        alreadyLiked: json["already_liked"],
        alreadyVoted: json["already_voted"],
      );
}

class Picture {
  Picture({
    this.imgSrc,
    this.imgWidth,
    this.imgHeight,
    this.imgSize,
  });

  final String? imgSrc;
  final int? imgWidth;
  final int? imgHeight;
  final int? imgSize;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        imgSrc: json["img_src"],
        imgWidth: json["img_width"],
        imgHeight: json["img_height"],
        imgSize: json["img_size"],
      );
}

class User {
  User({
    this.uid,
    this.headUrl,
    this.name,
  });

  final int? uid;
  final String? headUrl;
  final String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        headUrl: json["head_url"],
        name: json["name"],
      );
}
