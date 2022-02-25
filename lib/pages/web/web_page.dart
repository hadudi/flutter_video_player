// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/custom/navigationbar.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({
    Key? key,
    this.url,
  }) : super(key: key);

  String? url;
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UINavigationBar(
        title: '',
        leading: <Widget>[
          MaterialButton(
            padding: EdgeInsets.zero,
            minWidth: 42,
            onPressed: () {
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
      body: Container(),
    );
  }
}
