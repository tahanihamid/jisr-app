import 'package:flutter/material.dart';

void main() {
  runApp(const JisrApp());
}

class JisrApp extends StatelessWidget {
  const JisrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jisr App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Jisr Platform'),
        ),
      ),
    );
  }
}