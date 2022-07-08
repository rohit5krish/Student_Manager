import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/presentation/home/home_page.dart';

void deleteConfirmation(BuildContext context, bool isMultiDelete, int? index) {
  showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<StudentsCubit, StudentsState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(isMultiDelete
                  ? 'Delete Selected Students?'
                  : 'Delete Student?'),
              content: Text(isMultiDelete
                  ? 'Are you sure to want to delete the selected students?'
                  : 'Are you sure to want to delete the student?'),
              actions: [
                isMultiDelete
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          for (StudentModel dat in state.selectedStudents) {
                            int idx = state.studentsList.indexOf(dat);
                            BlocProvider.of<StudentsCubit>(context)
                                .deleteStudent(idx);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text('Deleted Students Successfully !'),
                            backgroundColor: Colors.red[400],
                          ));
                        },
                        child: const Text('Yes'))
                    : TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                          BlocProvider.of<StudentsCubit>(context)
                              .deleteStudent(index!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text('Deleted Student Successfully !'),
                            backgroundColor: Colors.red[400],
                          ));
                        },
                        child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'))
              ],
            );
          },
        );
      });
}
