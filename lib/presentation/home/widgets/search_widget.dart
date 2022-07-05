import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/students/students_cubit.dart';
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
        onChanged: (value) {
          BlocProvider.of<StudentsCubit>(context).searchStudent(value);
        },
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
