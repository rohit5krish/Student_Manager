import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';

class TopSection extends StatelessWidget {
  final String imageUrl;
  const TopSection({
    Key? key,
    required this.screenSize,
    required this.imageUrl,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 220,
          color: blackclr,
        ),
        SizedBox(
          height: 320,
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: blackclr,
            radius: 100,
          ),
        ),
        Positioned(
          top: 130,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 90,
            backgroundColor: Colors.white,
            child: Container(
              width: 165,
              height: 165,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(imageUrl)), fit: BoxFit.cover),
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(165)),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 7,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
              SizedBox(
                width: screenSize.width * 0.15,
              ),
              Text('Student Details', style: mainTitle),
            ],
          ),
        ),
      ],
    );
  }
}
