class Course {
  final String id;
  final String name;
  final String description;
  final String duration;
  final double fee;
  final String imageUrl;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.fee,
    required this.imageUrl,
  });

  // Factory constructor to create Course from Supabase Map
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      duration: map['duration'],
      fee: (map['fee'] as num).toDouble(),
      imageUrl: map['image_url'] ?? '', 
    );
  }
}
