class Student {
  final String id;
  final String name;
  final String email;
  final Course course; // Assuming you have a Course class with name property

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.course,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      course: Course.fromMap(map['courses']), // Adjust if nested differently
    );
  }
}

class Course {
  final String name;

  Course({required this.name});

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(name: map['name'] as String);
  }
}
