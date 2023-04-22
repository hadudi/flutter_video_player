import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/haokan_video/haokan_video_detail/haokan_video_detail_vm.dart';

import '../pages/haokan_video/haokan_video_detail/haokan_video_detail_model.dart';

class VodEposideProvider extends ChangeNotifier {
  VodEposideProvider({this.epsiderId = ""}) {
    viewModel = VodDetailViewModel();
  }

  String epsiderId = "";

  late VodDetailViewModel viewModel;
}
