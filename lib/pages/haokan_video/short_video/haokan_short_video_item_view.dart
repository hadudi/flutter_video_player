import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'haokan_short_video_model.dart';

class HaoKanShortVideoItemView extends StatefulWidget {
  const HaoKanShortVideoItemView({
    super.key,
    required this.model,
    required this.active,
  });

  final ShortVideoItem model;
  final bool active;

  @override
  State<HaoKanShortVideoItemView> createState() =>
      _HaoKanShortVideoItemViewState();
}

class _HaoKanShortVideoItemViewState extends State<HaoKanShortVideoItemView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
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
    super.didUpdateWidget(oldWidget);
    try {
      bool ret = oldWidget.model.id == widget.model.id;
      if (!ret) {
        _controller.pause();
        _controller.dispose();
        _controller =
            VideoPlayerController.network(widget.model.previewUrlHttp!);
      } else {
        _controller.pause();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> start() async {
    if (widget.active) {
      if (_controller.value.isInitialized) {
        await _controller.play();
      } else {
        await _controller.initialize();
        setState(() {});
      }
    } else {
      if (_controller.value.isPlaying) {
        await _controller.pause();
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
                      } else {
                        _controller.play();
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
                      child: Image.network(
                        widget.model.posterSmall!,
                      ),
                    ),
                  ),
                );
              },
            ),
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
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.model.authorAvatar!),
                ),
                IconButton(
                  onPressed: () {},
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
