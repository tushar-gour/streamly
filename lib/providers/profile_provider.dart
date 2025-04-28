import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';
import 'dart:convert';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  bool _isLoading = false;
  final ProfileService _profileService = ProfileService();

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile(String userId, String accessToken) async {
    _isLoading = true;
    notifyListeners();

    final response = await _profileService.getProfile(userId, accessToken);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _profile = Profile.fromJson(data['data']);
    } else {
      _profile = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(Map<String, dynamic> profileData, String accessToken) async {
    final response = await _profileService.updateProfile(profileData, accessToken);
    if (response.statusCode == 200) {
      await fetchProfile(profileData['id'], accessToken);
      return true;
    }
    return false;
  }

  Future<bool> updateAvatar(String accessToken, String filePath) async {
    final response = await _profileService.updateAvatar(accessToken, filePath);
    if (response.statusCode == 200) {
      // Optionally refresh profile avatar
      return true;
    }
    return false;
  }

  Future<bool> updateCoverImage(String accessToken, String filePath) async {
    final response = await _profileService.updateCoverImage(accessToken, filePath);
    if (response.statusCode == 200) {
      // Optionally refresh profile cover image
      return true;
    }
    return false;
  }
}
