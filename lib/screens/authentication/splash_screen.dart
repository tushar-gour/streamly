import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _checkLoginStatus(userProvider);
  }

  void navigate(String route) {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
  }

  Future<void> _checkLoginStatus(UserProvider userProvider) async {
    final username = await _secureStorage.read(key: 'username');
    final password = await _secureStorage.read(key: 'password');

    if (username != null && password != null) {
      final success = await userProvider.login(username, password);
      if (!mounted) return;
      navigate(success ? '/home' : '/login');
    } else {
      navigate('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
