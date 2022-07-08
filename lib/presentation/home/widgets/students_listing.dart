import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';

class StudentsList extends StatelessWidget {
  final String name;
  final String imgUrl;
  final bool selectClr;
  const StudentsList(
      {Key? key,
      required this.name,
      required this.imgUrl,
      required this.selectClr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: selectClr ? Colors.red[400] : blackclr,
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
              image: DecorationImage(
                image: FileImage(File(imgUrl)),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          sbWidth10,
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          selectClr ? const Icon(Icons.check_circle_rounded) : Container(),
          sbWidth10
        ],
      ),
    );
  }
}
