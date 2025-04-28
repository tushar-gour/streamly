import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/video.dart';
import '../services/video_service.dart';

class VideoProvider with ChangeNotifier {
  List<Video> _videos = [];
  bool _isLoading = false;
  final VideoService _videoService = VideoService();

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;

  Future<void> fetchVideos({int page = 1, int limit = 10, String? query}) async {
    _isLoading = true;
    notifyListeners();

    final response = await _videoService.getVideos();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> videosJson = data['data'];
      _videos = videosJson.map((json) => Video.fromJson(json)).toList();
    } else {
      _videos = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
