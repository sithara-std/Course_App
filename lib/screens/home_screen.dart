import 'package:course_app/models/course.dart';
import 'package:course_app/screens/feedback_list_screen.dart';
import 'package:course_app/screens/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'course_list_screen.dart';
import 'register_course_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  int index = 0;

  // List of courses loaded from Supabase
  List<Course> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await supabase.from('courses').select();

      setState(() {
        courses = (data).map((e) => Course.fromMap(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0 ? _homeContent() : _otherScreens(),
      
      floatingActionButton: index == 0
      ? FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 35, 77, 132),
          icon: const Icon(Icons.feedback, color: Colors.white),
          label: const Text(
            "Feedback",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FeedbackListScreen(),
              ),
            );
          },
        )
      : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        selectedItemColor: const Color(0xFF4A5CFF),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Students"),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: "Register"),
        ],
      ),
    );
  }

  // ================= HOME UI =================
  Widget _homeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // ===== BLUE HEADER =====
          Container(
            padding: const EdgeInsets.fromLTRB(20, 55, 20, 35),
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 1, 6, 49),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Row
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/736x/42/b5/76/42b57666dbe879a032955b85c5dcdcd5.jpg"),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        "Hi! Sithara",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.notifications_none, color: Colors.white, size: 26),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  "Find your favorite \ncourse here!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 24),

                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(64),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search Course",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                      suffixIcon: Icon(Icons.mic, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ===== FEATURE CARDS =====
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _FeatureItem(icon: Icons.design_services, title: "Design"),
                _FeatureItem(icon: Icons.campaign, title: "Marketing"),
                _FeatureItem(icon: Icons.video_camera_back, title: "Editing"),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== TRENDING =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Trending Courses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // You can navigate to full courses screen here
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(color: Color.fromARGB(255, 50, 66, 213), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Course List from Supabase with modern card style
          SizedBox(
            height: 220,
            width: double.infinity,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : courses.isEmpty
                    ? const Center(child: Text("No courses found"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: courses.length,
                        itemBuilder: (context, i) {
                          final course = courses[i];

                          // Demo rating from 1 to 5 (for UI only)
                          final int demoRating = (i % 5) + 1;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              bool isFavorite = false;

                              return Container(
                                width: 260,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 29, 6, 68),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(255, 10, 3, 23).withAlpha(77),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: course.imageUrl.startsWith('http')
                                                ? Image.network(
                                                    course.imageUrl,
                                                    height: 130,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    course.imageUrl,
                                                    height: 130,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isFavorite = !isFavorite;
                                                });
                                              },
                                              child: Icon(
                                                // ignore: dead_code
                                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                                // ignore: dead_code
                                                color: isFavorite ? Colors.red : Colors.white,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //const SizedBox(height: 5),
                                      Text(
                                        course.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: List.generate(5, (index) {
                                          bool filled = index < demoRating;
                                          return Icon(
                                            filled ? Icons.star : Icons.star_border,
                                            color: Colors.amber,
                                            size: 20,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ================= OTHER SCREENS =================
  Widget _otherScreens() {
    switch (index) {
      case 1:
        return const CourseListScreen();
      case 2:
        return const StudentListScreen();
      case 3:
        return const RegisterCourseScreen();
      default:
        return Container();
    }
  }
}

// ================= FEATURE ITEM =================
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    // Define some vibrant gradient colors for each feature dynamically
    final gradients = [
      [const Color.fromARGB(255, 22, 3, 74), Colors.deepPurpleAccent],
      [const Color.fromARGB(255, 91, 9, 180), const Color.fromARGB(255, 216, 7, 188)],
      [Colors.blue, const Color.fromARGB(255, 2, 151, 114)],
    ];

    // Pick gradient based on title or icon (simple example: index)
    final index = {
      "Design": 0,
      "Marketing": 1,
      "Editing": 2,
    }[title] ?? 0;

    final gradientColors = gradients[index];

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors.last.withValues(alpha: 0.6),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
