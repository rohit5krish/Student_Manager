import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/presentation/home/home_page.dart';
import 'package:student_management/presentation/student_details/widgets/details_widget.dart';
import 'package:student_management/presentation/student_details/widgets/top_section.dart';
import 'package:student_management/presentation/update_student/update_student.dart';

class StudentDetails extends StatelessWidget {
  final int index;
  const StudentDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<StudentsCubit, StudentsState>(
        builder: (context, state) {
          final datas = state.studentsList[index];
          return Column(
            children: [
              TopSection(screenSize: screenSize, imageUrl: datas.image),
              Text(
                datas.name,
                style: TextStyle(color: blackclr, fontSize: 30),
              ),
              Container(width: 50, height: 3, color: Colors.deepOrange),
              sbHeight20,
              Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.35,
                decoration: BoxDecoration(
                    color: blackclr, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailsWidget(
                      detailKey: 'Age :',
                      detailValue: datas.age,
                    ),
                    DetailsWidget(
                      detailKey: 'Batch :',
                      detailValue: datas.branch,
                    ),
                    DetailsWidget(
                      detailKey: 'Place :',
                      detailValue: datas.place,
                    ),
                    DetailsWidget(
                      detailKey: 'Phone :',
                      detailValue: datas.phone,
                    ),
                  ],
                ),
              ),
              sbHeight50,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          fixedSize: const Size(170, 45)),
                      onPressed: () {
                        BlocProvider.of<StudentsCubit>(context)
                            .updateImage(state.studentsList[index].image);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UpdateStudent(index: index, studentDat: datas);
                        }));
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Details')),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red, fixedSize: const Size(170, 45)),
                      onPressed: () {
                        deleteConfirm(context);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Delete Student')),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  deleteConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Student'),
            content: Text('Are You Sure to want to delete the student?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                    BlocProvider.of<StudentsCubit>(context)
                        .deleteStudent(index);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Student Deleted!'),
                      backgroundColor: Colors.red[400],
                    ));
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
