import 'dart:io';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class VideoService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> getVideos() async {
    final uri = Uri.parse('\$baseUrl/videos');
    final response = await http.get(uri);
    return response;
  }

  Future<http.Response> getVideoById(String videoId) async {
    final uri = Uri.parse('\$baseUrl/videos/\$videoId');
    final response = await http.get(uri);
    return response;
  }

  Future<http.StreamedResponse> uploadVideo(String title, String description,
      File videoFile, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/videos');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer \$accessToken';
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.files
        .add(await http.MultipartFile.fromPath('video', videoFile.path));
    return await request.send();
  }
}
