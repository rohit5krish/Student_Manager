import 'package:flutter/material.dart';
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
      // backgroundColor: Colors.white,

      body: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        children: [
          Stack(
            children: [
              SizedBox(
                height: screenSize.height * 0.16,
              ),
              // Top Container Design
              Container(
                height: screenSize.height * 0.12,
                decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: NetworkImage(
                    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSklBg3Lz9Ie46vdM99HO_1mwLXTAzclQHQ-HLMirZMMhEiqr2HUbpAIUxGye7qItff1Io&usqp=CAU'),
                    //     fit: BoxFit.cover),
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
          sbHeight10,
          // Listing Students
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return sbHeight20;
              },
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return StudentDetails();
                      }));
                    },
                    child: StudentsList(index: index));
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddStudent();
          }));
        },
        child: Icon(
          Icons.add,
          color: blackclr,
          size: 30,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
