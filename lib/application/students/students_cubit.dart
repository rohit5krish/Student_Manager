import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/main.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsState(studentsList: dbBox.values.toList()));

  void addStudent(StudentModel studentData) {
    dbBox.add(studentData);
    return emit(StudentsState(studentsList: dbBox.values.toList()));
  }

  void deleteStudent(int idx) {
    final keys = dbBox.keys;
    final studentKey = keys.elementAt(idx);
    dbBox.delete(studentKey);
    return emit(StudentsState(studentsList: dbBox.values.toList()));
  }

  void updateStudent(StudentModel studentData, int idx) {
    final keys = dbBox.keys;
    final studentKey = keys.elementAt(idx);
    dbBox.put(studentKey, studentData);
    return emit(StudentsState(studentsList: dbBox.values.toList()));
  }

  void updateImage(String img) {
    return emit(
        StudentsState(studentsList: dbBox.values.toList(), imgPath: img));
  }

  void searchStudent(String query) {
    final allDetails = dbBox.values.toList();
    final result;
    if (query.isEmpty) {
      result = allDetails;
    } else {
      result = allDetails
          .where((student) => student.name.toLowerCase().startsWith(query))
          .toList();
    }
    return emit(StudentsState(studentsList: result));
  }

  void multiSelection(StudentModel data) {
    if (state.selectedStudents.contains(data)) {
      state.selectedStudents.remove(data);
      return emit(StudentsState(
          studentsList: state.studentsList,
          selectedStudents: state.selectedStudents));
    } else {
      List<StudentModel> selectedStudentsList = [];
      selectedStudentsList.addAll(state.selectedStudents);
      selectedStudentsList.add(data);
      return emit(StudentsState(
          studentsList: state.studentsList,
          selectedStudents: selectedStudentsList));
    }
  }

  bool onBackPress() {
    if (state.selectedStudents.isEmpty) {
      return true;
    } else {
      emit(StudentsState(
          studentsList: state.studentsList, selectedStudents: []));
      return false;
    }
  }
}
