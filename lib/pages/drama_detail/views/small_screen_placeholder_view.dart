// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

class SmallScreenPlayerPlaceHolderView extends StatelessWidget {
  const SmallScreenPlayerPlaceHolderView({
    Key? key,
    required this.coverUrl,
  }) : super(key: key);

  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = width * 0.56;
    return SizedBox(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Image.network(
              coverUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                blendMode: BlendMode.modulate,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                coverUrl,
                height: height - 52,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
