import 'package:course_app/screens/student_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen>
    with SingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  bool _isLoading = true;
  List<Map<String, dynamic>> students = [];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fetchStudents();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchStudents() async {
    try {
      final data = await supabase
          .from('students')
          .select()
          .order('name', ascending: true);

      setState(() {
        students = (data as List).cast<Map<String, dynamic>>();
        _isLoading = false;
      });

      _animationController.forward(from: 0);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load students: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registered Students',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: const Color.fromARGB(255, 1, 6, 49),
      ),
      backgroundColor: Colors.grey[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchStudents,
              child: students.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 300),
                        Center(
                          child: Text(
                            'No registered students found.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final courses = student['registered_courses'] ?? [];

                        final animation = Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index / students.length,
                              1,
                              curve: Curves.easeOut,
                            ),
                          ),
                        );

                        return FadeTransition(
                          opacity: _animationController,
                          child: SlideTransition(
                            position: animation,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        StudentDetailScreen(student: student),
                                  ),
                                );
                              },
                              child: Card(
                                color:
                                    const  Color.fromARGB(255, 201, 206, 209),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Row(
                                        children: [
                                          const Icon(Icons.person,
                                              size: 18),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              student['name'] ?? 'No Name',
                                              style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 55, 6, 139),
                                            ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const Icon(Icons.email_outlined,
                                              size: 16),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              student['email'] ?? 'No Email',
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      const Text(
                                        "Registered Courses:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 6,
                                        children:
                                            (courses as List<dynamic>).map(
                                          (course) {
                                            return Chip(
                                              label:
                                                  Text(course.toString()),
                                              backgroundColor: Colors
                                                  .deepPurple.shade50,
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
