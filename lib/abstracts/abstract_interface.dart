import 'package:flutter_video_player/http/http_response_model.dart';

abstract class Request {
  Future requestData({
    int pageNum = 1,
    Map<String, dynamic> queryParams = const {},
  });

  Future handleData(ResponseModel model);
}
