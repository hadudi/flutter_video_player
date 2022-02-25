// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/custom/navigationbar.dart';
import 'package:flutter_video_player/http/http_response_model.dart';
import 'package:flutter_video_player/models/models.dart';
import 'package:flutter_video_player/pages/home/model/home_model.dart';
import 'package:flutter_video_player/pages/home/views/cell_list.dart';

import '../../abstracts/abstract_interface.dart';

class DramaListPageView extends StatefulWidget {
  DramaListPageView({
    Key? key,
    required this.model,
  }) : super(key: key);

  DramaCoverModel? model;

  @override
  _DramaListPageViewState createState() => _DramaListPageViewState();
}

class _DramaListPageViewState extends State<DramaListPageView> with Request {
  late List<SectionContentModel> itemArray = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UINavigationBar(
        title: widget.model?.coverUrl,
        leading: <Widget>[
          MaterialButton(
            padding: EdgeInsets.zero,
            minWidth: 42,
            onPressed: () {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Color(0xff32383a),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(left: 12, right: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 6,
          childAspectRatio: 0.564,
        ),
        itemCount: itemArray.length,
        itemBuilder: (ctx, index) => ListCell(
          model: itemArray[index],
        ),
      ),
    );
  }

  @override
  Future handleData(ResponseModel model) async {
    setState(() {
      var list = model.map['content'];
      if (list is List) {
        for (var element in list) {
          itemArray.add(SectionContentModel.fromJson(element));
        }
      }
    });
  }

  @override
  Future requestData({
    int pageNum = 1,
    Map<String, dynamic> queryParams = const {},
  }) async {
    // final url = widget.model?.dramaId ?? '';
    // final decoder = Uri.decodeFull(url);
    // final uri = Uri.parse(decoder);
    // final seriesId = uri.queryParameters['seriesId'] ?? '';
  }
}
