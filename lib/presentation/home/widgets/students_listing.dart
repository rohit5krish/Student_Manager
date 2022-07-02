import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';

class StudentsList extends StatelessWidget {
  final int index;
  const StudentsList({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: blackclr,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              // color: Colors.blue,
              image: const DecorationImage(
                image: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5603AQFlijk7Al-WwQ/profile-displayphoto-shrink_200_200/0/1632900587777?e=1660176000&v=beta&t=odTh8YWZxKhCTCOG5w3j5O3G016nDY-AI2PlGMRovEc'),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          sbWidth10,
          Text(
            'Student ${index + 1}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
