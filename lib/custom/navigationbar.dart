// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_video_player/util/util.dart';

class UINavigationBar extends StatelessWidget implements PreferredSizeWidget {
  UINavigationBar({
    Key? key,
    this.title = '',
    this.isCenterTitle = true,
    this.isSecondPage = true,
    this.leading = const [],
    this.middleView,
    this.tailing = const [],
    this.color = Colors.white,
    this.height = 44.0,
  }) : super(key: key);

  final String? title;
  final Widget? middleView;
  final List<Widget>? leading;
  final List<Widget>? tailing;
  Color? color;
  final double? height;

  bool? isCenterTitle;
  bool? isSecondPage;
  EdgeInsets insets = const EdgeInsets.fromLTRB(12, 0, 12, 0);

  @override
  Size get preferredSize => const Size.fromHeight(Util.navBarHeight);

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [];

    if (leading?.isNotEmpty == true) {
      // for (var i = 0; i < widget.leading!.length; i++) {
      //   views.add(
      //     Positioned.fromRect(
      //       rect: Rect.fromLTWH(widget.insets.left + i * 100, 0, 100, 40),
      //       child: widget.leading![i],
      //     ),
      //   );
      // }
      views.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: leading!,
        ),
      );
    }

    if (title?.isNotEmpty == true) {
      if (isCenterTitle == true) {
        views.add(
          Center(
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xff32383a),
                fontWeight:
                    isSecondPage == true ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        );
      } else {
        views.add(
          Positioned(
            left: insets.left,
            child: Text(
              title!,
              style: TextStyle(
                color: const Color(0xffFAFbFC),
                fontSize: 16,
                fontWeight:
                    isSecondPage == true ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        );
      }
    }

    if (middleView != null) {
      views.add(
        Center(
          child: middleView!,
        ),
      );
    }

    if (tailing?.isNotEmpty == true) {
      views.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: tailing!,
        ),
      );
    }
    return Container(
      color: color,
      child: Column(
        children: [
          Container(
            height: Util.statusBarHeight,
          ),
          SizedBox(
            height: Util.navBarHeight,
            child: Stack(
              alignment: Alignment.center,
              children: views,
            ),
          )
        ],
      ),
    );
  }
}
