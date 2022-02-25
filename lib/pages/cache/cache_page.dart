// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/custom/navigationbar.dart';

class CacheViewPage extends StatefulWidget {
  const CacheViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _CacheViewPageState createState() => _CacheViewPageState();
}

class _CacheViewPageState extends State<CacheViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UINavigationBar(
        title: '设置',
        isCenterTitle: false,
        tailing: <Widget>[
          MaterialButton(
            padding: EdgeInsets.zero,
            minWidth: 42,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('编辑'),
          ),
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
      ),
    );
  }
}
