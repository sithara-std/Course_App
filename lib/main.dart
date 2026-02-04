import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ddvvvooabvgrjgdgzulm.supabase.co',
    anonKey: 'sb_publishable_Flu4Tl6t8bL9wrQrGQ6HGQ_Kqc8fXdT'
  );
  runApp(const InstituteApp());
}

class InstituteApp extends StatelessWidget {
  const InstituteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Institute App',
      theme: AppTheme.lightTheme,
      home: DashboardScreen(),
    );
  }
}
