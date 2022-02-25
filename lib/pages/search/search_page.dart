import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/util.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text('搜索'),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFB2B8C2),
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: Util.instance.contentHeight(),
            maxWidth: MediaQuery.of(context).size.width,
          ),
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        ),
      ],
    );
  }
}
