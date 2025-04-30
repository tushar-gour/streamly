import 'package:flutter/material.dart';
import '../models/like.dart';
import '../services/like_service.dart';
import 'dart:convert';

class LikeProvider with ChangeNotifier {
  List<Like> _likedVideos = [];
  bool _isLoading = false;
  final LikeService _likeService = LikeService();

  List<Like> get likedVideos => _likedVideos;
  bool get isLoading => _isLoading;

  Future<void> fetchLikedVideos(String accessToken) async {
    _isLoading = true;
    notifyListeners();

    final response = await _likeService.getLikedVideos(accessToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> likesJson = data['data'];
      _likedVideos = likesJson.map((json) => Like.fromJson(json)).toList();
    } else {
      _likedVideos = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> toggleVideoLike(String videoId, String accessToken) async {
    final response = await _likeService.toggleVideoLike(videoId, accessToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      await fetchLikedVideos(accessToken);
      return true;
    }
    return false;
  }

  Future<bool> toggleCommentLike(String commentId, String accessToken) async {
    final response =
        await _likeService.toggleCommentLike(commentId, accessToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Optionally refresh liked comments or update local state
      return true;
    }
    return false;
  }

  Future<bool> isVideoLiked({
    required String userId,
    required String videoId,
    required String accessToken,
  }) async {
    final response = await _likeService.isVideoLiked(videoId, accessToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['liked'] ?? false;
    }
    return false;
  }

  Future<bool> likeVideo({
    required String userId,
    required String videoId,
    required String accessToken,
  }) async {
    final response = await _likeService.likeVideo(videoId, accessToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      await fetchLikedVideos(accessToken);
      return true;
    }
    return false;
  }

  Future<bool> unlikeVideo({
    required String userId,
    required String videoId,
    required String accessToken,
  }) async {
    final response = await _likeService.unlikeVideo(videoId, accessToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      await fetchLikedVideos(accessToken);
      return true;
    }
    return false;
  }
}
