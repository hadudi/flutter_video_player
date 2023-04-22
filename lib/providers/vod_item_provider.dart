import 'package:flutter/material.dart';

import '../pages/haokan_video/haokan_home/haokan_home_model.dart';
// import '../pages/haokan_video/haokan_video_detail/haokan_video_detail_model.dart';

class VodItemProvider extends ChangeNotifier {
  DramaItemModel? _vodModel;

  DramaItemModel? get vodModel => _vodModel;
  Future chooseVod(DramaItemModel? vodModel) async {
    _vodModel = vodModel;
    notifyListeners();
  }
}
