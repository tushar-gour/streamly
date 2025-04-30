import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class LikeService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> toggleVideoLike(String videoId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/toggle/v/\$videoId');
    final response = await http.post(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> toggleCommentLike(String commentId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/toggle/c/\$commentId');
    final response = await http.post(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> getLikedVideos(String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/videos');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> likeVideo(String videoId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/v/\$videoId');
    final response = await http.post(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> unlikeVideo(String videoId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/v/\$videoId');
    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> isVideoLiked(String videoId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/likes/v/\$videoId');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }
}
