import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show jsonDecode;
import 'package:flutter_video_player/uitl/r_sources.dart';
import 'http_response_model.dart';

enum Api {
  home,
  dramaDetail,
  dramaList,
  search,
  mine,
  sendVerifyCode,
  verifyCodeLogin,
  logout,
  categoryHeader,
  categoryPage,
  dramaPlay,
}

class HttpConfig {
  static Future<ResponseModel?> request({
    required Api api,
    Map<String, dynamic> queryParams = const {},
  }) async {
    String jsp = '';
    switch (api) {
      case Api.home:
        jsp = R.Jsp.homePage;
        break;
      case Api.categoryHeader:
        jsp = R.Jsp.categoryFilter;
        break;
      case Api.categoryPage:
        if (queryParams['page'] == 1) {
          jsp = R.Jsp.categoryPage1;
        } else {
          jsp = R.Jsp.categoryPage2;
        }
        break;
      case Api.dramaDetail:
        jsp = R.Jsp.dramaDetail;
        break;
      case Api.dramaPlay:
        String episodeId = queryParams['episodeId'];
        switch (int.parse(episodeId)) {
          case 1:
            jsp = R.Jsp.play1Detail;
            break;
          case 2:
            jsp = R.Jsp.play2Detail;
            break;
          case 3:
            jsp = R.Jsp.play3Detail;
            break;
          case 4:
            jsp = R.Jsp.play4Detail;
            break;
          default:
        }
        break;
      case Api.mine:
        jsp = R.Jsp.minePage;
        break;
      case Api.sendVerifyCode:
        jsp = R.Jsp.loginSendCode;
        break;
      case Api.verifyCodeLogin:
        jsp = R.Jsp.loginUserInfo;
        break;
      default:
        break;
    }

    if (jsp.isNotEmpty) {
      try {
        String jsonString = await rootBundle.loadString(jsp);
        final json = jsonDecode(jsonString);
        return ResponseModel.fromJson(json);
      } catch (e) {
        return null;
      }
    }
  }
}
