import 'package:course_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------- BOTTOM NAV STYLE CARD ----------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 54, 54, 75),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                  SizedBox(width: 6),
                  CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                  SizedBox(width: 6),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF4C5BCE),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Title
              const Text(
                "Welcome\nOur Course",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                "Here you can learn new and\nmost interesting things for you!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 26),

              // Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C5BCE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Let's Start",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ---------- BODY ----------
      body: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Image.network(
              "https://i.pinimg.com/1200x/eb/30/ec/eb30ec1805c7565788d838b3ca8c02b6.jpg",
              height: MediaQuery.of(context).size.height * 2.45,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
