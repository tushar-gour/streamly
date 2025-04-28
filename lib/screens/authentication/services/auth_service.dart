import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> loginUser({
    required String? username,
    required String? email,
    required String password,
  }) async {
    final url = Uri.parse('\$baseUrl/Users/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', data['data']['accessToken']);
        await prefs.setString('refreshToken', data['data']['refreshToken']);

        return true;
      } else {
        throw const HttpException(
            'Login failed: \${response.statusCode} - \${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: \$e');
    }
  }

  Future<bool> logoutUser() async {
    final url = Uri.parse('\$baseUrl/logout');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer \$accessToken',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('accessToken');
        await prefs.remove('refreshToken');
        return true;
      } else {
        throw const HttpException(
          'Logout failed: \${response.statusCode} - \${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error during logout: \$e');
    }
  }

  Future<bool> signupUser({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required File avatar,
    File? coverImage,
  }) async {
    final url = Uri.parse('\$baseUrl/Users/register');

    var request = http.MultipartRequest('POST', url);

    request.fields['fullName'] = fullName;
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    request.files.add(await http.MultipartFile.fromPath('avatar', avatar.path));

    if (coverImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'coverImage',
          coverImage.path,
        ),
      );
    }

    try {
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return true;
      } else {
        final data = jsonDecode(response.body);
        print(data);
        throw const HttpException(
          "Signup failed: \${response.statusCode} - \${data['message']}",
        );
      }
    } catch (e) {
      throw Exception('Error occurred during signup: \$e');
    }
  }
}
