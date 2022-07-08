part of 'students_cubit.dart';

class StudentsState {
  final List<StudentModel> studentsList;
  String? imgPath;
  List<StudentModel> selectedStudents;
  StudentsState(
      {required this.studentsList, this.imgPath, this.selectedStudents=const[]});
}
