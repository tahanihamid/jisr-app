import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

const Color brandColor = Color(0xFF199A9E);
const Color brandColorLight = Color(0xFF199A9E);
const Color brandColorDark = Color(0xFF1565C0);

Color get activeBrandColor =>
    themeNotifier.value == ThemeMode.dark ? brandColorDark : brandColorLight;

Color get backgroundColor =>
    themeNotifier.value == ThemeMode.dark ? const Color(0xFF121212) : Colors.white;

Color get cardColor =>
    themeNotifier.value == ThemeMode.dark ? const Color(0xFF1E1E1E) : Colors.white;

Color get textColor =>
    themeNotifier.value == ThemeMode.dark ? Colors.white : Colors.black87;

Color get subtextColor =>
    themeNotifier.value == ThemeMode.dark ? Colors.grey.shade400 : Colors.grey.shade600;