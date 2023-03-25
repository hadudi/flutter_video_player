import 'package:flutter/material.dart';

enum PageType {
  home,
  video,
}

class JJTabItem {
  late PageType type;
  late String? title;
  late IconData icon;

  JJTabItem({
    required this.type,
    required this.icon,
    this.title,
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
      backgroundColor: Colors.black,
      enableFeedback: false,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blueGrey,
      type: BottomNavigationBarType.shifting,
      items: widget.tabItems
          .map(
            (e) => BottomNavigationBarItem(
              tooltip: '',
              icon: Icon(
                e.icon,
                // size: 30,
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
