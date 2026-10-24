import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import '../theme/colors.dart';

const _logoSize = 100.0;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 26),
              const Text(
                'JISR',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: brandColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your bridge to the future',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
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
      child: Icon(
        Icons.hub_outlined,
        size: 52,
        color: brandColor,
      ),
    );
  }
}