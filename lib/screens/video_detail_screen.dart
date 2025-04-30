import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/video.dart';
import 'video_comments_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/like_provider.dart';
import '../services/like_service.dart';

class VideoDetailScreen extends StatefulWidget {
  final Video video;

  const VideoDetailScreen({super.key, required this.video});

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailScreenState();
  }
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isLiked = false;

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
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    bool liked = await likeProvider.isVideoLiked(
      userId: userProvider.user?.id ?? '',
      videoId: widget.video.id,
      accessToken: userProvider.token ?? '',
    );
    setState(() {
      _isLiked = liked;
    });
  }

  Future<void> _toggleLike() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    if (_isLiked) {
      await likeProvider.unlikeVideo(
        userId: userProvider.user?.id ?? '',
        videoId: widget.video.id,
        accessToken: userProvider.token ?? '',
      );
    } else {
      await likeProvider.likeVideo(
        userId: userProvider.user?.id ?? '',
        videoId: widget.video.id,
        accessToken: userProvider.token ?? '',
      );
    }
    setState(() {
      _isLiked = !_isLiked;
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: _isLiked ? Colors.blue : null,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoCommentsScreen(
                        videoId: widget.video.id,
                        userId: userProvider.user?.id ?? '',
                        accessToken: userProvider.token ?? '',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
