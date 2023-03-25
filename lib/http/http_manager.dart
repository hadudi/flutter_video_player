import 'package:dio/dio.dart';
import 'http_response_model.dart';

enum Method {
  get('get'),
  post('post');

  final String name;
  const Method(this.name);
}

enum NetApi {
  haokanHome,
  haokanDramaDetail,
  haokanShortVideoList,
}

enum BaseUrl {
  haokan('https://haokan.baidu.com');

  final String url;
  const BaseUrl(this.url);
}

extension ApiOption on NetApi {
  /// The target's base `URL`.
  String get url {
    return BaseUrl.haokan.url;
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
      case NetApi.haokanShortVideoList:
        path = '/web/video/feed';
        break;
    }
    return path;
  }

  /// The HTTP method used in the request.
  Method get method {
    return Method.get;
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
      baseUrl: BaseUrl.haokan.url,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   error: true,
    // ));
  }

  static final HttpManager _instance = HttpManager._();

  late NetApi _api;
  late Dio _dio;

  late int timeOffset = 0;

  Map<String, dynamic> handleHeader({
    required NetApi req,
    Map<String, dynamic> queryParams = const {},
  }) {
    _api = req;
    _dio.options.baseUrl = _api.url;
    var map = {
      'Connection': 'keep-alive',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:99.0) Gecko/20100101 Firefox/99.0',
      'cookie':
          '''BDSFRCVID=c1_OJeC626aK5nnjgoo9MozGo5juxMvTH6_n187bKjvEKUwq14RvEG0PWM8g0KubAAvGogKK0eOTHkDF_2uxOjjg8UtVJeC6EG0Ptf8g0f5; H_BDCLCKID_SF=tb4eVCDhtK_3HJrgK4nEbKC-Mfc-2toj-Po2WbCQKKjr8pcNLTDKj4_UjfTXatbyab5uW-cTaK58ftnE5lO1jl4HDHAf5fnBbeTi-43htCbCfl5jDh3RXjksD-Rt5foCbevy0hvctn5cShncQMjrDRLbXU6BK5vPbNcZ0l8K3l02V-bIe-t2b6Qh-p52f6LffRvP; BAIDUID=8ED28EA890D23FBC1A07098B29B39D41:FG=1; Hm_lvt_4aadd610dfd2f5972f1efee2653a2bc5=1676626410; PC_TAB_LOG=video_details_page; COMMON_LID=8aa63b07fb4c2cb150e61a57b0efdf7f; hkpcvideolandquery=%u5224%u521124%u5E74%uFF0C%u623F%u4EA7%u88AB%u6267%u884C%uFF0C%u59BB%u5B50%u626B%u5730%u51FA%u95E8%uFF0C%u9648%u7EE7%u5FD7%u53D1%u751F%u7FFB%u5929%u8986%u5730%u53D8%u5316; BIDUPSID=8ED28EA890D23FBC1A07098B29B39D41; PSTM=1678689672; H_PS_PSSID=36560_38271_38128_37861_38172_38289_38253_38261_37936_38312_38382_38284_26350_37881; BDSFRCVID_BFESS=c1_OJeC626aK5nnjgoo9MozGo5juxMvTH6_n187bKjvEKUwq14RvEG0PWM8g0KubAAvGogKK0eOTHkDF_2uxOjjg8UtVJeC6EG0Ptf8g0f5; H_BDCLCKID_SF_BFESS=tb4eVCDhtK_3HJrgK4nEbKC-Mfc-2toj-Po2WbCQKKjr8pcNLTDKj4_UjfTXatbyab5uW-cTaK58ftnE5lO1jl4HDHAf5fnBbeTi-43htCbCfl5jDh3RXjksD-Rt5foCbevy0hvctn5cShncQMjrDRLbXU6BK5vPbNcZ0l8K3l02V-bIe-t2b6Qh-p52f6LffRvP; delPer=0; PSINO=5; BA_HECTOR=2k8l80aga52g848h8l84205k1i104m51n; BAIDUID_BFESS=8ED28EA890D23FBC1A07098B29B39D41:FG=1; ZFY=TSnHf:BWLRcaprIQRmSv30jF4Pya8qaW9kvXR6YUg8uA:C; Hm_lpvt_4aadd610dfd2f5972f1efee2653a2bc5=1678788621; ariaDefaultTheme=undefined; RT="z=1&dm=baidu.com&si=88760cc2-7298-4f45-a767-1efdbb8252ab&ss=lf83e62o&sl=3&tt=4a5&bcn=https%3A%2F%2Ffclog.baidu.com%2Flog%2Fweirwood%3Ftype%3Dperf&ld=9nj&ul=exl&hd=f9b"''',
    };
    return map;
  }

  Future<ResponseCallBack> sendRequest({
    required NetApi req,
    Map<String, dynamic> queryParams = const {},
  }) async {
    try {
      var headers = handleHeader(req: req, queryParams: queryParams);
      Response response = await _dio.request(
        req.path,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
          method: _api.method.name,
        ),
      );
      if (response.statusCode == 200) {
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
    return await HttpManager._instance
        .sendRequest(req: req, queryParams: queryParams);
  }
}
