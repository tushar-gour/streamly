import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;
  bool _isAuthenticated = false;
  final UserService _userService = UserService();

  User? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String usernameOrEmail, String password) async {
    final response = await _userService.loginUser(usernameOrEmail, password);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['accessToken'] ?? '';
      _user = User.fromJson(data['user']);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
