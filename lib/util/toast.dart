import 'package:flutter/material.dart';

class Toast {
  static OverlayEntry? _overlayEntry;
  static DateTime _startedTime = DateTime.now();

  static show(BuildContext context, String msg) async {
    _startedTime = DateTime.now();
    OverlayState? state = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            top: MediaQuery.of(context).size.height / 2 - 20,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(18),
                  child: AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      );
    } else {}
    if (_overlayEntry?.mounted == false) {
      state.insert(_overlayEntry!);
    } else {
      _overlayEntry?.markNeedsBuild();
    }

    await Future.delayed(const Duration(seconds: 2));
    if (DateTime.now().difference(_startedTime).inSeconds >= 2) {
      if (_overlayEntry != null && _overlayEntry?.mounted == true) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    }
  }
}
