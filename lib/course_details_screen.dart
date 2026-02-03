import 'package:course_app/screens/register_course_screen.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// ---------- APP BAR ----------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Course Detail",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.favorite_border),
          ),
        ],
      ),

      /// ---------- BOTTOM BAR ----------
      bottomNavigationBar: _BottomBar(course: course),

      /// ---------- BODY ----------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// COURSE IMAGE
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  "https://i.pinimg.com/736x/da/63/48/da63487b942587c165c0b631a4baa894.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                course.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// INFO ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _InfoItem(
                    icon: Icons.access_time,
                    title: "Duration",
                    value: "9:30 AM - 11:30 AM",
                  ),
                  _InfoItem(
                    icon: Icons.group,
                    title: "Students",
                    value: "250+",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "This project-based course helps you master practical skills "
                "from basics to advanced level with real-world examples.",
                style: TextStyle(
                  color: const Color.fromARGB(255, 43, 43, 43),
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TABS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  _TabItem(title: "Introduction",selected: true),
                  SizedBox(width: 15,),
                  _TabItem(title: "Basics", selected: false),
                  SizedBox(width: 15,),
                  _TabItem(title: "Benefits", selected: false),
                  SizedBox(width: 15,),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// LESSON LIST
            const _LessonTile(
              title: "Introduction to Course",
              duration: "3:20 Min",
            ),
            const _LessonTile(
              title: "Understanding Basics",
              duration: "5:10 Min",
            ),
            const _LessonTile(
              title: "Practical Example",
              duration: "7:45 Min",
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

//// ---------------- INFO ITEM ----------------
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.grey),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//// ---------------- TAB ITEM ----------------
class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;

  const _TabItem({required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? const Color(0xFF4C5BCE) : Colors.grey,
          decoration:
              selected ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}

//// ---------------- LESSON TILE ----------------
class _LessonTile extends StatelessWidget {
  final String title;
  final String duration;

  const _LessonTile({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.play_circle_fill,
              color: Color(0xFF4C5BCE),
              size: 34,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//// ---------------- BOTTOM BAR ----------------
class _BottomBar extends StatelessWidget {
  //final Course course;
  //const _BottomBar({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rs ${course.fee}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterCourseScreen(),
                ),
              );
            }, // UI ONLY
           style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 114, 118, 149),
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Register Now →",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
