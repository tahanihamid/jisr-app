import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/colors.dart';

void main() {
  runApp(const JisrApp());
}

class JisrApp extends StatelessWidget {
  const JisrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jisr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandColor),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}