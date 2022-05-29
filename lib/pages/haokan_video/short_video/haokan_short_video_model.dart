import 'package:flutter/material.dart';

class HaoKanShortVideoModel {
  HaoKanShortVideoModel({
    this.videos,
  });

  final List<ShortVideoItem>? videos;

  factory HaoKanShortVideoModel.fromJson(Map<String, dynamic> json) =>
      HaoKanShortVideoModel(
        videos: List<ShortVideoItem>.from(
          json["videos"].map(
            (x) => ShortVideoItem.fromJson(x),
          ),
        ),
      );
}

class ShortVideoItem {
  ShortVideoItem({
    this.id,
    this.title,
    this.posterSmall,
    this.posterBig,
    this.posterPc,
    this.sourceName,
    this.playUrl,
    this.duration,
    this.url,
    this.showTag,
    this.publishTime,
    this.isPayColumn,
    this.like,
    this.comment,
    this.playcnt,
    this.fmplaycnt,
    this.fmplaycnt2,
    this.outstandTag,
    this.previewUrlHttp,
    this.thirdId,
    this.vip,
    this.authorAvatar,
  });

  final String? id;
  final String? title;
  final String? posterSmall;
  final String? posterBig;
  final String? posterPc;
  final String? sourceName;
  final String? playUrl;
  final String? duration;
  final String? url;
  final int? showTag;
  final String? publishTime;
  final int? isPayColumn;
  final String? like;
  final String? comment;
  final String? playcnt;
  final String? fmplaycnt;
  final String? fmplaycnt2;
  final String? outstandTag;
  final String? previewUrlHttp;
  final String? thirdId;
  final int? vip;
  final String? authorAvatar;

  Size get size {
    List<String>? list = posterSmall?.split(',');
    String? ws =
        list?.firstWhere((element) => element.startsWith('w_')).substring(2) ??
            '1';
    String? hs =
        list?.firstWhere((element) => element.startsWith('h_')).substring(2) ??
            '1';
    double w = double.tryParse(ws) ?? 1;
    double h = double.tryParse(hs) ?? 1;
    return Size(w, h);
  }

  double get aspectRatio => size.width / size.height;

  factory ShortVideoItem.fromJson(Map<String, dynamic> json) => ShortVideoItem(
        id: json["id"],
        title: json["title"],
        posterSmall: json["poster_small"],
        posterBig: json["poster_big"],
        posterPc: json["poster_pc"],
        sourceName: json["source_name"],
        playUrl: json["play_url"],
        duration: json["duration"],
        url: json["url"],
        showTag: json["show_tag"],
        publishTime: json["publish_time"],
        isPayColumn: json["is_pay_column"],
        like: json["like"],
        comment: json["comment"],
        playcnt: json["playcnt"],
        fmplaycnt: json["fmplaycnt"],
        fmplaycnt2: json["fmplaycnt_2"],
        outstandTag: json["outstand_tag"],
        previewUrlHttp: json["previewUrlHttp"],
        thirdId: json["third_id"],
        vip: json["vip"],
        authorAvatar: json["author_avatar"],
      );
}
