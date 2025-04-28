import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../globals/global_constants.dart';

class UserService {
  final Logger _logger = Logger();

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<Map<String, dynamic>> updateAccountDetails({
    required String fullname,
    required String email,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/update-account-details');

    try {
      final response = await http.post(
        url,
        headers: _buildHeaders(token),
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // Return updated user details
      } else {
        throw Exception(
            'Failed to update account. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error updating account: $error');
    }
  }

  Future<void> updateUserAvatar({
    required File avatarImage,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/avatar');

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath(
          'avatar',
          avatarImage.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        _logger.i('Avatar updated successfully: $responseBody');
      } else {
        throw Exception(
            'Failed to update avatar. Status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating avatar: $error');
    }
  }

  Future<void> updateCoverImage({
    required File coverImage,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/cover-image');

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath(
          'coverImage',
          coverImage.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        throw Exception('Cover image updated successfully: $responseBody');
      } else {
        throw Exception(
            'Failed to update cover image. Status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating cover image: $error');
    }
  }

  Future<Map<String, dynamic>> getUserChannelProfile({
    required String username,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/c/$username');

    try {
      final response = await http.get(
        url,
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // Return profile data
      } else {
        throw Exception(
            'Failed to fetch channel profile. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching channel profile: $error');
    }
  }

  Future<List<dynamic>> getWatchHistory({required String token}) async {
    final url = Uri.parse('$baseUrl/watch-history');

    try {
      final response = await http.get(
        url,
        headers: _buildHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']; // Return watch history
      } else {
        throw Exception(
            'Failed to fetch watch history. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching watch history: $error');
    }
  }
}
