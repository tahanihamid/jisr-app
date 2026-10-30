import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'peers_screen.dart';
import 'profile_screen.dart';
import 'advisor_screen.dart';
import 'assessments_screen.dart';
import 'certificates_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 4;
  bool _isDark = false;

  final List<String> _titles = const [
    'Peers',
    'AI Advisor',
    'Assessments',
    'Certificates',
    'Profile',
  ];

  final List<Widget> _pages = const [
    PeersScreen(),
    AdvisorScreen(),
    AssessmentsScreen(),
    CertificatesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = _isDark
        ? ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF1E1E1E),
            primaryColor: brandColorDark,
            colorScheme: ColorScheme.dark(
              primary: brandColorDark,
              surface: const Color(0xFF1E1E1E),
            ),
          )
        : ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.white,
            primaryColor: brandColor,
            colorScheme: const ColorScheme.light(
              primary: brandColor,
              surface: Colors.white,
            ),
          );

    return Theme(
      data: themeData,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                _titles[_currentIndex],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    _isDark ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: () {
                    setState(() {
                      _isDark = !_isDark;
                      themeNotifier.value =
                          _isDark ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                ),
              ],
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: _isDark ? brandColorDark : brandColor,
              unselectedItemColor: Colors.grey.shade500,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  activeIcon: Icon(Icons.people),
                  label: 'Peers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_awesome_outlined),
                  activeIcon: Icon(Icons.auto_awesome),
                  label: 'Advisor',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment),
                  label: 'Tests',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium_outlined),
                  activeIcon: Icon(Icons.workspace_premium),
                  label: 'Certificates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}