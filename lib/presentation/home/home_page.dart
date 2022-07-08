import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/presentation/add_student/add_student.dart';
import 'package:student_management/presentation/widgets/delete_confirmation.dart';
import 'package:student_management/presentation/home/widgets/search_widget.dart';
import 'package:student_management/presentation/home/widgets/students_listing.dart';
import 'package:student_management/presentation/student_details/student_details.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return BlocProvider.of<StudentsCubit>(context).onBackPress();
      },
      child: Scaffold(
        body: SafeArea(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.15,
                    ),
                    // Top Container Design
                    Container(
                      height: screenSize.height * 0.12,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 6, 6, 6),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17),
                          )),
                    ),
                    // Contents in top container
                    Positioned(
                      top: screenSize.height * 0.025,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const Text('Student Manager', style: mainTitle),
                          sbHeight20,

                          // Refactored Searching Function
                          SearchWidget(screenSize: screenSize)
                        ],
                      ),
                    )
                  ],
                ),
                // Listing Students
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                    child: BlocBuilder<StudentsCubit, StudentsState>(
                      builder: (context, state) {
                        if (state.studentsList.isEmpty) {
                          return const Center(
                            child: Text('No Students Data Available'),
                          );
                        } else {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return sbHeight20;
                            },
                            itemCount: state.studentsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final studentDatas = state.studentsList[index];
                              final bool isSelected;

                              isSelected =
                                  state.selectedStudents.contains(studentDatas);

                              return GestureDetector(
                                  onLongPress: () {
                                    BlocProvider.of<StudentsCubit>(context)
                                        .multiSelection(studentDatas);
                                  },
                                  onTap: () {
                                    if (state.selectedStudents.isEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return StudentDetails(
                                          index: index,
                                        );
                                      }));
                                    } else {
                                      BlocProvider.of<StudentsCubit>(context)
                                          .multiSelection(studentDatas);
                                    }
                                  },
                                  child: StudentsList(
                                    name: studentDatas.name,
                                    imgUrl: studentDatas.image,
                                    selectClr: isSelected,
                                  ));
                            },
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<StudentsCubit, StudentsState>(
          builder: (context, state) {
            if (state.selectedStudents.isEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddStudent();
                  }));
                },
                child: const Icon(
                  Icons.add,
                  color: blackclr,
                  size: 30,
                ),
                backgroundColor: Colors.grey[400],
              );
            } else {
              return FloatingActionButton(
                onPressed: () {
                  deleteConfirmation(context, true, null);
                },
                child: const Icon(
                  Icons.delete,
                  color: blackclr,
                  size: 30,
                ),
                backgroundColor: Colors.red[400],
              );
            }
          },
        ),
      ),
    );
  }
}
