import 'package:flutter/material.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  static final List<Course> courses = [
    Course(
      id: "1",
      name: "Flutter Development",
      description: "Build modern mobile ",
      duration: "3 Months",
      fee: 35000,
    ),
    Course(
      id: "2",
      name: "Cyber Security",
      description: "Security fundamentals",
      duration: "4 Months",
      fee: 45000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Courses"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4C5BCE),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}
