import 'package:flutter/material.dart';
import 'globals/themes.dart';
import 'screens/home_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/authentication/registration_screen.dart';
import 'screens/authentication/splash_screen.dart';

void main() {
  runApp(const StreamlyApp());
}

class StreamlyApp extends StatelessWidget {
  const StreamlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streamly',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
