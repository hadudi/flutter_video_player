// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/custom/navigationbar.dart';

class SettiingViewPage extends StatefulWidget {
  const SettiingViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingViewPageState createState() => _SettingViewPageState();
}

class _SettingViewPageState extends State<SettiingViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UINavigationBar(
        title: '设置',
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
      body: Container(
        color: Colors.black87,
        height: 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            children: List.generate(20, (index) => Chip(label: Text('$index'))),
          ),
        ),
      ),
    );
  }
}
