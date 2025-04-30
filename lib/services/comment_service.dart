import 'dart:convert';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class CommentService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> getVideoComments(String videoId,
      {int page = 1, int limit = 10}) async {
    final uri =
        Uri.parse('\$baseUrl/comments/\$videoId').replace(queryParameters: {
      'page': page.toString(),
      'limit': limit.toString(),
    });
    final response = await http.get(uri);
    return response;
  }

  Future<http.Response> addComment(
      String videoId, String userId, String content, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/comments/\$videoId');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$accessToken',
      },
      body: jsonEncode({
        'userId': userId,
        'content': content,
      }),
    );
    return response;
  }

  Future<http.Response> updateComment(
      String commentId, String content, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/comments/c/\$commentId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$accessToken',
      },
      body: jsonEncode({'content': content}),
    );
    return response;
  }

  Future<http.Response> deleteComment(
      String commentId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/comments/c/\$commentId');
    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }
}
