import 'dart:convert';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class ProfileService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> getProfile(String userId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/users/\$userId');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> updateProfile(Map<String, dynamic> profileData, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/users/update-account-details');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$accessToken',
      },
      body: jsonEncode(profileData),
    );
    return response;
  }

  Future<http.Response> updateAvatar(String accessToken, String filePath) async {
    final uri = Uri.parse('\$baseUrl/users/avatar');
    var request = http.MultipartRequest('PATCH', uri);
    request.headers['Authorization'] = 'Bearer \$accessToken';
    request.files.add(await http.MultipartFile.fromPath('avatar', filePath));
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> updateCoverImage(String accessToken, String filePath) async {
    final uri = Uri.parse('\$baseUrl/users/cover-image');
    var request = http.MultipartRequest('PATCH', uri);
    request.headers['Authorization'] = 'Bearer \$accessToken';
    request.files.add(await http.MultipartFile.fromPath('coverImage', filePath));
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
