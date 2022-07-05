import 'package:hive_flutter/adapters.dart';

part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String branch;

  @HiveField(3)
  final String place;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final image;

  StudentModel({
    required this.name,
    required this.age,
    required this.branch,
    required this.place,
    required this.phone,
    required this.image,
  });
}
