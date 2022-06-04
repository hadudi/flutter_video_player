// ignore_for_file: must_be_immutable, camel_case_types, unnecessary_const, prefer_const_constructors, unnecessary_brace_in_string_interps, overridden_fields, prefer_function_declarations_over_variables

import 'dart:async';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

mixin OverlayAction {
  void onTap();
  void onDoubleTap();
  void onRightLongPress();
}

abstract class ControllerOverlayCallback {
  late final VoidCallback? smallScreenCallback;
  late final VoidCallback? fullScreenCallback;
  late final VoidCallback? nextSourceCallback;
}

abstract class ControllerOverlay {
  late final AnimationController animationCtrl;

  var showControl = false;

  var sliderRate = 0.0;

  StreamSubscription<bool>? _subscriptor;

  // 播放器
  @protected
  late final VideoPlayerController? _player;

  late final VoidCallback? _listener;

  void positionChanged() {
    var position = _player?.value.position ?? Duration.zero;
    var duration = _player?.value.duration ?? Duration.zero;
    positionDes = timeFormator(position);
    videoDuration = _player?.value.duration.inSeconds ?? 0;
    durationDes = timeFormator(duration);
    rateValue = position.inSeconds / (videoDuration != 0 ? videoDuration : 1);
  }

  // 视频是否初始化成功，可以播放
  bool get _isInitialized => _player?.value.isInitialized ?? false;

  bool get _isPlaying => _player?.value.isPlaying ?? false;

  // 播放位置
  String positionDes = '--:--';

  // 视频时长
  String durationDes = '--:--';

  // 视频总时长，seconds
  int videoDuration = 0;

  // 视频播放时长比例，进度条进度
  double rateValue = 0.0;

  // 是否在拖动进度条
  bool isSlidering = false;

  // 播放倍数
  final playbackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
  ];

  Future pause() async {
    if (_isPlaying) {
      await _player?.pause();
    }
  }

  Future play() async {
    if (!_isPlaying) {
      await _player?.play();
    }
  }

  Future togglePlay() async {
    _isPlaying ? await _player?.pause() : await _player?.play();
  }

  Future<void> setVolume(double volume) async {
    await _player?.setVolume(volume);
  }

  Future seekToTime(int seekTime) async {
    int seconds = seekTime.remainder(60).toInt();
    int minutes = (seekTime ~/ 60).toInt();
    int hours = (seekTime ~/ 3600).toInt();
    return await _player?.seekTo(Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    ));
  }

  // 是否播放结束
  bool get _isPlayToEnd =>
      _player?.value.position == _player?.value.duration && !_isPlaying;

  Future seekToEnd() async {
    return await _player?.seekTo(_player?.value.duration ?? Duration.zero);
  }

  String timeFormator(Duration duration) {
    String twoDigits(int n) {
      if (n > 9) return "$n";
      return "0$n";
    }

    int hours = duration.inHours.remainder(24);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return hours > 0
        ? '${hours}:$twoDigitMinutes:$twoDigitSeconds'
        : '$twoDigitMinutes:$twoDigitSeconds';
  }

  Future<bool> hideControlOverlay() async {
    await Future.delayed(Duration(seconds: 5));
    return true;
  }

  // 保持控制页面显示5秒
  void keepShowControlOverlay5second(VoidCallback? completed) {
    _subscriptor?.cancel();
    _subscriptor = hideControlOverlay().asStream().listen((event) {
      if (event) {
        completed?.call();
      }
    });
  }

  void seekToRelativePosition(
    BuildContext context,
    Offset globalPosition,
  ) {
    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject != null) {
      final box = renderObject as RenderBox;
      final Offset tapPos = box.globalToLocal(globalPosition);
      final double relative = tapPos.dx / box.size.width;
      // if (relative > 0) {
      //   final Duration position = controller!.value.duration! * relative;
      //   lastSeek = position;
      //   await betterPlayerController!.seekTo(position);
      //   onFinishedLastSeek();
      //   if (relative >= 1) {
      //     lastSeek = controller!.value.duration;
      //     await betterPlayerController!.seekTo(controller!.value.duration!);
      //     onFinishedLastSeek();
      //   }
      // }
      final Duration position =
          (_player?.value.duration ?? Duration.zero) * relative;
      _player?.seekTo(position);
    }
  }
}

class PlayerControllerOverlay extends StatefulWidget
    implements ControllerOverlayCallback {
  PlayerControllerOverlay({
    Key? key,
    required this.player,
    this.isFullScreen = false,
    this.smallScreenCallback,
    this.fullScreenCallback,
    this.nextSourceCallback,
  }) : super(key: key);

  final VideoPlayerController player;
  bool isFullScreen;

  @override
  PlayerControllerOverlayState createState() => PlayerControllerOverlayState();

  @override
  VoidCallback? smallScreenCallback;

  @override
  VoidCallback? fullScreenCallback;

  @override
  VoidCallback? nextSourceCallback;
}

class PlayerControllerOverlayState extends State<PlayerControllerOverlay>
    with SingleTickerProviderStateMixin, ControllerOverlay
    implements OverlayAction {
  @override
  VideoPlayerController? get _player => widget.player;

  var changed = false;

  Widget get slider => SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 2,
          activeTrackColor: const Color(0xfffb6060),
          inactiveTrackColor: const Color(0x33fafbfc),
          inactiveTickMarkColor: const Color(0xfffb6060),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          thumbColor: const Color(0xfffb6060),
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 6,
          ),
        ),
        child: Slider(
          value: isSlidering ? sliderRate : rateValue,
          onChanged: (value) {
            if (isSlidering) {
              showControl = true;
              keepControlOverlayInShow();
            }
            updateState(() {
              rateValue = value;
              sliderRate = value;
            });
          },
          onChangeStart: (double startValue) {
            isSlidering = true;
          },
          onChangeEnd: (endValue) async {
            isSlidering = false;
            await seekToTime((endValue * videoDuration).round());
            updateState(() {
              rateValue = endValue;
            });
          },
        ),
      );

  IconButton get playBtn => IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 45),
        onPressed: () {
          togglePlay();
          updateState(() {
            showControl = true;
            animationCtrl.reset();
            animationCtrl.forward();
          });
          keepControlOverlayInShow();
        },
        icon: AnimatedIcon(
          icon:
              _isPlaying ? AnimatedIcons.play_pause : AnimatedIcons.pause_play,
          progress: animationCtrl,
          size: 24,
          color: Colors.white,
        ),
      );

  Text get positionText => Text(
        positionDes,
        style: const TextStyle(
          color: Color(0xffFAFBFC),
          fontSize: 10,
        ),
      );

  Text get durationText => Text(
        durationDes,
        style: const TextStyle(
          color: Color(0xffFAFBFC),
          fontSize: 10,
        ),
      );

  List<Widget> get smallScreenOverlay => <Widget>[
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: AnimatedContainer(
            height: showControl ? 60 : 0,
            duration: Duration(milliseconds: 300),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0x80000000),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  playBtn,
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: positionText,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: slider,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: durationText,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 44),
                    icon: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      widget.fullScreenCallback?.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  List<Widget> get fullScreenOverlay => <Widget>[
        Positioned(
          child: SafeArea(
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                widget.smallScreenCallback?.call();
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: AnimatedContainer(
            height: showControl ? 100 : 0,
            duration: Duration(milliseconds: 300),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0x80000000),
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(top: 29),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: positionText,
                          ),
                          Expanded(
                            child: Container(
                              height: 10,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: slider,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: durationText,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.zero,
                            child: playBtn,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: IconButton(
                              onPressed: () {
                                // widget.changeSourceCallback?.call();
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(
                                minWidth: 40,
                              ),
                              icon: Icon(
                                Icons.skip_next,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];

  void updateState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationCtrl.forward();
    _listener = () {
      positionChanged();
      if (_player != null && mounted) {
        updateState(() {
          if (_isPlayToEnd && !changed) {
            changed = true;
            widget.nextSourceCallback?.call();
          }
        });
      }
    };
    _player?.addListener(_listener!);
  }

  @override
  void didUpdateWidget(covariant PlayerControllerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_listener != null) {
      oldWidget.player.removeListener(_listener!);
      widget.player.addListener(_listener!);
      changed = false;
    }
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    if (_listener != null) {
      _player?.removeListener(_listener!);
    }
    super.dispose();
  }

  @override
  @mustCallSuper
  MultiChildRenderObjectWidget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = width * 0.56;
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          // onLongPressStart: (details) {
          //   Offset location = details.localPosition;
          //   if (location.dx >= MediaQuery.of(context).size.width * 0.2) {
          //     _player?.setPlaybackSpeed(3.0);
          //   }
          // },
          // onLongPressCancel: () {
          //   _player?.setPlaybackSpeed(1.0);
          // },
          onVerticalDragUpdate: (details) {
            Offset location = details.localPosition;
            if (location.dx <= width * 0.5) {
              setVolume(1 - location.dy / height);
            }
          },
          onHorizontalDragStart: (details) {
            if (_isInitialized) {
              return;
            }
            pause();
          },
          onHorizontalDragUpdate: (details) {
            if (_isInitialized) {
              return;
            }
            seekToRelativePosition(context, details.globalPosition);
          },
          onHorizontalDragEnd: (details) {
            play();
          },
        ),
        ...(widget.isFullScreen ? fullScreenOverlay : smallScreenOverlay),
      ],
    );
  }

  void keepControlOverlayInShow() {
    keepShowControlOverlay5second(() {
      updateState(() {
        showControl = false;
      });
    });
  }

  @override
  void onTap() {
    setState(() {
      showControl = !showControl;
    });
    keepControlOverlayInShow();
  }

  @override
  void onDoubleTap() {
    togglePlay();
  }

  @override
  void onRightLongPress() {}
}

/*

                              // Spacer(),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text('倍数'),
                              // ),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text('选集'),
                              // ),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text('原画'),
                              // ),
*/
