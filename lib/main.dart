import 'package:flutter/material.dart';
import 'package:velora_watch/screens/login_screen.dart';
import 'package:velora_watch/screens/register_screen.dart';
import 'package:velora_watch/screens/home_screen.dart';
import 'package:velora_watch/themes/app_themes.dart';

void main() {
  runApp(const VeloraWatchesApp());
}

class VeloraWatchesApp extends StatelessWidget {
  const VeloraWatchesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velora Watches',
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Start the app on the LoginScreen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
