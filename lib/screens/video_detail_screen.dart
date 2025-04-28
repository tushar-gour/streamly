import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/video.dart';

class VideoDetailScreen extends StatefulWidget {
  final Video video;

  const VideoDetailScreen({Key? key, required this.video}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailScreenState();
  }
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Column(
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white70,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ],
              ),
            )
          else
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.video.description),
          ),
          // TODO: Add comments, likes, and other video details here
        ],
      ),
    );
  }
}
