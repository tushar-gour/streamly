import 'package:flutter/material.dart';
import '../models/playlist.dart';
import '../services/playlist_service.dart';
import 'dart:convert';

class PlaylistProvider with ChangeNotifier {
  List<Playlist> _playlists = [];
  bool _isLoading = false;
  final PlaylistService _playlistService = PlaylistService();

  List<Playlist> get playlists => _playlists;
  bool get isLoading => _isLoading;

  Future<void> fetchPlaylists(String accessToken) async {
    _isLoading = true;
    notifyListeners();

    final response = await _playlistService.getPlaylists(accessToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> playlistsJson = data['data'];
      _playlists = playlistsJson.map((json) => Playlist.fromJson(json)).toList();
    } else {
      _playlists = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createPlaylist(Map<String, dynamic> playlistData, String accessToken) async {
    final response = await _playlistService.createPlaylist(playlistData, accessToken);
    if (response.statusCode == 201) {
      await fetchPlaylists(accessToken);
      return true;
    }
    return false;
  }

  Future<bool> updatePlaylist(String playlistId, Map<String, dynamic> playlistData, String accessToken) async {
    final response = await _playlistService.updatePlaylist(playlistId, playlistData, accessToken);
    if (response.statusCode == 200) {
      await fetchPlaylists(accessToken);
      return true;
    }
    return false;
  }

  Future<bool> deletePlaylist(String playlistId, String accessToken) async {
    final response = await _playlistService.deletePlaylist(playlistId, accessToken);
    if (response.statusCode == 200) {
      _playlists.removeWhere((playlist) => playlist.id == playlistId);
      notifyListeners();
      return true;
    }
    return false;
  }
}
