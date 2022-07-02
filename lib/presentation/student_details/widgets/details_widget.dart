import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';

class DetailsWidget extends StatelessWidget {
  final String detailKey;
  final String detailValue;
  const DetailsWidget({
    Key? key,
    required this.detailKey,
    required this.detailValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          detailKey,
          style: mainTitle,
        ),
        Text(
          detailValue,
          style: mainTitle,
        ),
      ],
    );
  }
}
