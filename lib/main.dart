import 'package:course_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

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
      home: const DashboardScreen(),
    );
  }
}
