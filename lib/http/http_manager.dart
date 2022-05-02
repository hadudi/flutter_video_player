import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'http_response_model.dart';

enum Method {
  get,
  post,
  delete,
  put,
}

enum NetApi {
  haokanHome,
  haokanDramaDetail,
  bilibiliHotVideo,
}

enum BaseUrl {
  bilibili,
  haokan,
  test,
}

extension BASEURL on BaseUrl {
  String get url {
    switch (this) {
      case BaseUrl.bilibili:
        return 'https://api.vc.bilibili.com';
      case BaseUrl.haokan:
        return 'https://haokan.baidu.com';
      default:
        return '';
    }
  }
}

extension ApiOption on NetApi {
  /// The target's base `URL`.
  String get url {
    switch (this) {
      case NetApi.haokanHome:
      case NetApi.haokanDramaDetail:
        return BaseUrl.haokan.url;
      case NetApi.bilibiliHotVideo:
        return BaseUrl.bilibili.url;
      default:
    }
    return BaseUrl.test.url;
  }

  /// The path to be appended to `baseURL` to form the full `URL`.
  String get path {
    var path = '';
    switch (this) {
      case NetApi.haokanHome:
        path = '/web/video/longpage';
        break;
      case NetApi.haokanDramaDetail:
        path = '/v';
        break;
      case NetApi.bilibiliHotVideo:
        path = '/link_draw/v2/Doc/index';
        break;
    }
    return path;
  }

  /// The HTTP method used in the request.
  Method get method {
    switch (this) {
      default:
        return Method.get;
    }
  }
}

extension MethodName on Method {
  String get name {
    switch (this) {
      case Method.get:
        return 'get';
      case Method.post:
        return 'post';
      case Method.delete:
        return 'delete';
      case Method.put:
        return 'put';
    }
  }
}

class ResponseCallBack {
  ResponseModel? model;
  DioError? error;

  ResponseCallBack(this.model, this.error);
}

// <T extends TargetType> 限定泛型的类型
class HttpManager {
  // 私有化构造方法
  HttpManager._() {
    var options = BaseOptions(
      baseUrl: BaseUrl.test.url,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   error: true,
    // ));
  }

  @protected
  static final HttpManager _instance = HttpManager._();

  @protected
  static HttpManager get instance => _instance;

  late NetApi api;
  late Dio dio;

  late int timeOffset = 0;

  Map<String, dynamic> handleHeader(
      {required NetApi req, Map<String, dynamic> queryParams = const {}}) {
    api = req;
    dio.options.baseUrl = api.url;
    var map = {
      'Connection': 'keep-alive',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:99.0) Gecko/20100101 Firefox/99.0',
    };
    return map;
  }

  Future<ResponseCallBack> sendRequest({
    required NetApi req,
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      var headers = handleHeader(req: req, queryParams: queryParams);
      Response response = await dio.request(
        req.path,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
          method: api.method.name,
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        ResponseModel model = ResponseModel.fromJson(response.data);
        return ResponseCallBack(model, null);
      } else {
        return ResponseCallBack(
          null,
          DioError(
            requestOptions: response.requestOptions,
            type: DioErrorType.response,
          ),
        );
      }
    } on DioError catch (e) {
      return ResponseCallBack(null, e);
    }
  }

  static Future<ResponseCallBack> request({
    required NetApi req,
    Map<String, dynamic> queryParams = const {},
  }) async {
    return await HttpManager.instance
        .sendRequest(req: req, queryParams: queryParams);
  }
}
