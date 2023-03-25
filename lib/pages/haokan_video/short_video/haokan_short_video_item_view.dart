import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/providers/config_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'haokan_short_video_model.dart';

class HaoKanShortVideoItemView extends StatefulWidget {
  const HaoKanShortVideoItemView({
    super.key,
    required this.model,
  });

  final ShortVideoItem model;

  @override
  State<HaoKanShortVideoItemView> createState() =>
      _HaoKanShortVideoItemViewState();
}

class _HaoKanShortVideoItemViewState extends State<HaoKanShortVideoItemView>
    with TickerProviderStateMixin {
  late final VideoPlayerController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  late final ValueNotifier<bool> _playNotify;

  late final bool active;

  @override
  void initState() {
    super.initState();
    _playNotify = ValueNotifier<bool>(true);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.model.previewUrlHttp != null) {
      _controller = VideoPlayerController.network(widget.model.previewUrlHttp!);
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(covariant HaoKanShortVideoItemView oldWidget) {
    try {
      // bool ret = oldWidget.model.id == widget.model.id;
      // if (!ret) {
      //   _controller.pause();
      //   _controller.dispose();
      //   _controller =
      //       VideoPlayerController.network(widget.model.previewUrlHttp!);
      // } else {
      //   _controller.pause();
      // }
      // ignore: empty_catches
    } catch (e) {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _playNotify.dispose();
    super.dispose();
  }

  Future<void> start() async {
    if (context.watch<ConfigProvider>().tabIndex == 1) {
      if (_controller.value.isInitialized) {
        if (!_playNotify.value) {
          return;
        }
        await _controller.play();
        _playNotify.value = true;
      } else {
        await _controller.initialize();
        setState(() {});
      }
    } else {
      if (_controller.value.isPlaying) {
        await _controller.pause();
        _playNotify.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: start(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller.value.isInitialized) {
                  return GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                        _playNotify.value = false;
                      } else {
                        _controller.play();
                        _playNotify.value = true;
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      color: Colors.black,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: widget.model.aspectRatio,
                      child: ExtendedImage.network(
                        widget.model.posterSmall!,
                        cacheMaxAge: const Duration(hours: 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _playNotify,
            builder: (context, value, child) {
              if (value) {
                return const SizedBox();
              }
              return Center(
                child: AnimatedScale(
                  scale: 1.5,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 60,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 16,
            right: 80,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.model.sourceName!}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model.title!,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 60,
            child: Column(
              children: [
                RotationTransition(
                  turns: _animation,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      widget.model.authorAvatar!,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _animationController.stop();
                  },
                  icon: const Icon(Icons.favorite),
                  color: Colors.red[400],
                  padding: const EdgeInsets.symmetric(vertical: 0),
                ),
                Text(
                  widget.model.like!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
