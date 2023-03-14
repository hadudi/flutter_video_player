import 'package:flutter/material.dart';

enum PageType {
  haokanVideo,
  hotVideo,
  category,
  comment,
}

class JJTabItem {
  late PageType type;
  late String? title;
  late IconData icon;
  late double iconSize;
  late Color? color;

  JJTabItem({
    required this.type,
    required this.title,
    required this.icon,
    this.iconSize = 26.0,
    this.color = Colors.greenAccent,
  });
}

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({
    super.key,
    required this.tabItems,
    required this.callback,
  });

  final List<JJTabItem> tabItems;

  final Function(int index)? callback;

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  late int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: false,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.blueGrey,
      items: widget.tabItems
          .map(
            (e) => BottomNavigationBarItem(
              tooltip: '',
              icon: Icon(
                e.icon,
                size: e.iconSize,
                color: e.color,
              ),
              label: e.title,
            ),
          )
          .toList(),
      onTap: (index) {
        if (_currentIndex == index) {
          return;
        }
        widget.callback?.call(index);
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
