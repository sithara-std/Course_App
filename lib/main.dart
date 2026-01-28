import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const InstituteApp());
}

class InstituteApp extends StatelessWidget {
  const InstituteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Institute App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}
