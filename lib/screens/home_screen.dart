import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/video_provider.dart';
import '../widgets/video_card.dart';
import 'video_detail_screen.dart';
import '../models/video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoProvider _videoProvider;

  @override
  void initState() {
    super.initState();
    _videoProvider = Provider.of<VideoProvider>(context, listen: false);
    _videoProvider.fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streamly'),
      ),
      body: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          if (videoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (videoProvider.videos.isEmpty) {
            return const Center(child: Text('No videos found.'));
          }
          return ListView.builder(
            itemCount: videoProvider.videos.length,
            itemBuilder: (context, index) {
              Video video = videoProvider.videos[index];
              return VideoCard(
                video: video,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoDetailScreen(video: video),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
