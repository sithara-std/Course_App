import 'package:course_app/screens/course_details_screen.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart'; // Make sure CourseCard supports navigation!

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Courses",
          style:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ) ,),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 6, 49),
      ),
      body: FutureBuilder<List<Course>>(
        future: CourseService().fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final courses = snapshot.data ?? [];

          if (courses.isEmpty) {
            return const Center(child: Text("No courses available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailScreen(course: course),
                    ),
                  );
                },
                child: CourseCard(course: course),
              );
            },
          );
        },
      ),
    );
  }
}
