import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';
import 'dart:convert';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];
  bool _isLoading = false;
  final CommentService _commentService = CommentService();

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments(String videoId, {int page = 1, int limit = 10}) async {
    _isLoading = true;
    notifyListeners();

    final response = await _commentService.getVideoComments(videoId, page: page, limit: limit);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> commentsJson = data['data']['comments'];
      _comments = commentsJson.map((json) => Comment.fromJson(json)).toList();
    } else {
      _comments = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addComment(String videoId, String userId, String content, String accessToken) async {
    final response = await _commentService.addComment(videoId, userId, content, accessToken);
    if (response.statusCode == 201) {
      await fetchComments(videoId);
      return true;
    }
    return false;
  }

  Future<bool> updateComment(String commentId, String content, String accessToken) async {
    final response = await _commentService.updateComment(commentId, content, accessToken);
    if (response.statusCode == 200) {
      // Optionally refresh comments or update local state
      return true;
    }
    return false;
  }

  Future<bool> deleteComment(String commentId, String accessToken) async {
    final response = await _commentService.deleteComment(commentId, accessToken);
    if (response.statusCode == 200) {
      _comments.removeWhere((comment) => comment.id == commentId);
      notifyListeners();
      return true;
    }
    return false;
  }
}
