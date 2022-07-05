import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/presentation/add_student/add_student.dart';
import 'package:student_management/presentation/home/widgets/search_widget.dart';
import 'package:student_management/presentation/home/widgets/students_listing.dart';
import 'package:student_management/presentation/student_details/student_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
                            return InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return StudentDetails(
                                      index: index,
                                    );
                                  }));
                                },
                                child: StudentsList(
                                    name: studentDatas.name,
                                    imgUrl: studentDatas.image));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddStudent();
          }));
        },
        child: const Icon(
          Icons.add,
          color: blackclr,
          size: 30,
        ),
        backgroundColor: Colors.grey[400],
      ),
    );
  }
}
