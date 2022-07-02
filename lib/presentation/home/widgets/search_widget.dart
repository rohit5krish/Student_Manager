import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * 0.85,
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          filled: true,
          fillColor: Colors.grey[350],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(color: blackclr),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: blackclr,
          ),
        ),
      ),
    );
  }
}
