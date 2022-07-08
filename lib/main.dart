import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/presentation/home/home_page.dart';

final dbBox = Hive.box<StudentModel>('student_db');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentsCubit(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {'/home': (context) => HomePage()},
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
        home: HomePage(),
      ),
    );
  }
}
