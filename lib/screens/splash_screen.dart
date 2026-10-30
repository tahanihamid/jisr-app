import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import '../theme/colors.dart';

const _logoSize = 110.0;
const _splashDuration = Duration(seconds: 2);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_splashDuration, _goToLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _goToLogin() {
    if (!mounted) return;
    HapticFeedback.lightImpact();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 24),
              Text(
                'JISR',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: brandColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Together, we can build the future',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subtextColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: _logoSize,
      height: _logoSize,
      decoration: BoxDecoration(
        color: brandColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
      ),
     child: Image.asset(
        'assets/logo.png',
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.extension_rounded,
            size: 56,
            color: brandColor,
          );
        },
      ),
    );
  }
}