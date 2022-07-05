import 'package:flutter/material.dart';
import 'package:flutter_video_player/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettiingViewPage extends StatefulWidget {
  const SettiingViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingViewPageState createState() => _SettingViewPageState();
}

class _SettingViewPageState extends State<SettiingViewPage> {
  late final SharedPreferences prefs;
  bool _canCellarPlay = false;
  bool _canCellarDownload = false;

  final items = [
    '允许移动网络播放',
    '允许移动网络下载',
    '清理缓存',
    'APP版本',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future initData() async {
    prefs = await SharedPreferences.getInstance();
    _canCellarPlay = prefs.getBool('canCellarPlay') ?? false;
    _canCellarDownload = prefs.getBool('canCellarDownload') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initData(),
        builder: (context, snap) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: Util.navBarHeight,
              backgroundColor: Colors.white,
              title: const Text(
                '设置',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.5,
              leading: MaterialButton(
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
            ),
            body: Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SwitchListTile(
                      title: Text(items[index]),
                      value: _canCellarPlay,
                      onChanged: (onChanged) async {
                        await prefs.setBool('canCellarPlay', onChanged);
                        setState(() {
                          _canCellarPlay = onChanged;
                        });
                      },
                    );
                  }
                  if (index == 1) {
                    return SwitchListTile(
                      title: Text(items[index]),
                      value: _canCellarDownload,
                      onChanged: (onChanged) async {
                        await prefs.setBool('canCellarDownload', onChanged);
                        setState(() {
                          _canCellarDownload = onChanged;
                        });
                      },
                    );
                  }
                  return ListTile(
                    title: Text(items[index]),
                    contentPadding: const EdgeInsets.only(left: 16, right: 30),
                    trailing:
                        index == 2 ? const Text('10M') : const Text('1.0.0'),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    indent: 18,
                  );
                },
                itemCount: items.length,
              ),
            ),
          );
        });
  }
}
