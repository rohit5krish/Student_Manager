import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/presentation/student_details/widgets/details_widget.dart';
import 'package:student_management/presentation/student_details/widgets/top_section.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          TopSection(screenSize: screenSize),
          const Text(
            'Ajay KJ',
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
              children: const [
                DetailsWidget(
                  detailKey: 'Age :',
                  detailValue: '23',
                ),
                DetailsWidget(
                  detailKey: 'Batch :',
                  detailValue: 'BCE25',
                ),
                DetailsWidget(
                  detailKey: 'Place :',
                  detailValue: 'Kochi',
                ),
                DetailsWidget(
                  detailKey: 'Phone :',
                  detailValue: '8089384827',
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
                      primary: Colors.green, fixedSize: const Size(170, 45)),
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Details')),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, fixedSize: const Size(170, 45)),
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                  label: const Text('Delete Student')),
            ],
          ),
        ],
      ),
    );
  }
}
