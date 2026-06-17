import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const CityScoutApp());
}

class CityScoutApp extends StatelessWidget {
  const CityScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CityScout',
      home: const SplashScreen(),
    );
  }
}