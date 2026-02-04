import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';

class CourseService {
  final _client = Supabase.instance.client;

  Future<List<Course>> fetchCourses() async {
    try {
      // direct list data from the query
      final data = await _client.from('courses').select() as List<dynamic>;

      return data.map((e) => Course.fromMap(e as Map<String, dynamic>)).toList();
    } catch (error) {
      // handle or rethrow error
      throw Exception('Failed to fetch courses: $error');
    }
  }

  Future<Course> fetchCourseById(String id) async {
    try {
      // single object from query
      final data = await _client
          .from('courses')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (data == null) {
        throw Exception('Course not found');
      }

      return Course.fromMap(data);
    } catch (error) {
      throw Exception('Failed to fetch course by id: $error');
    }
  }
}
