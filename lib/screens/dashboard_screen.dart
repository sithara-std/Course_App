import 'package:flutter/material.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // modern purple
      body: SafeArea(
        child: Stack(
          children: [
            // Top Image
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.network(
                  "https://i.pinimg.com/1200x/eb/30/ec/eb30ec1805c7565788d838b3ca8c02b6.jpg", // student image
                  height: 400,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 350,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 220, 232),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Page indicator dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                        SizedBox(width: 6),
                        CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                        SizedBox(width: 6),
                        CircleAvatar(radius: 4, backgroundColor: Color(0xFF4C5BCE)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Title
                    const Text(
                      "Welcome\nOur Course",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    const Text(
                      "Here you can learn new and\nmost interesting things for you!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 30),

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
                          "Lets Start",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
