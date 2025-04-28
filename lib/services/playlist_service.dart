import 'dart:convert';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class PlaylistService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> getPlaylists(String accessToken) async {
    final uri = Uri.parse('\$baseUrl/playlists');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }

  Future<http.Response> createPlaylist(
      Map<String, dynamic> playlistData, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/playlists');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$accessToken',
      },
      body: jsonEncode(playlistData),
    );
    return response;
  }

  Future<http.Response> updatePlaylist(String playlistId,
      Map<String, dynamic> playlistData, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/playlists/\$playlistId');
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$accessToken',
      },
      body: jsonEncode(playlistData),
    );
    return response;
  }

  Future<http.Response> deletePlaylist(
      String playlistId, String accessToken) async {
    final uri = Uri.parse('\$baseUrl/playlists/\$playlistId');
    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer \$accessToken'},
    );
    return response;
  }
}
