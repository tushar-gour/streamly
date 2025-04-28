import 'dart:convert';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class UserService {
  final String baseUrl = Globals.baseUrl;

  Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('\$baseUrl/users/register');
    var request = http.MultipartRequest('POST', url);

    userData.forEach((key, value) {
      if (value is String) {
        request.fields[key] = value;
      }
    });

    if (userData['avatar'] != null) {
      request.files.add(await http.MultipartFile.fromPath('avatar', userData['avatar']));
    }
    if (userData['coverImage'] != null) {
      request.files.add(await http.MultipartFile.fromPath('coverImage', userData['coverImage']));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> loginUser(String usernameOrEmail, String password) async {
    final url = Uri.parse('\$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameOrEmail,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> getCurrentUser(String accessToken) async {
    final url = Uri.parse('\$baseUrl/users/current-user');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer \$accessToken',
      },
    );
    return response;
  }

  // Add other user-related API methods as needed
}
