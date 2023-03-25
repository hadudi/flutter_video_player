import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_home/haokan_home_model.dart';

class VodItemProvider extends ChangeNotifier {
  DramaItemModel? _vodModel;

  DramaItemModel? get vodModel => _vodModel;

  chooseVod(DramaItemModel? vodModel) {
    if (_vodModel != vodModel) {
      _vodModel = vodModel;
      notifyListeners();
    }
  }
}
