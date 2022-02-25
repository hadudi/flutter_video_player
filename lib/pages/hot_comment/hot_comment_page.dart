import 'package:flutter/material.dart';

class HotCommentPage extends StatefulWidget {
  const HotCommentPage({Key? key}) : super(key: key);

  @override
  _HotCommentPageState createState() => _HotCommentPageState();
}

class _HotCommentPageState extends State<HotCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.ac_unit,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
