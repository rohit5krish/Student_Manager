import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/presentation/widgets/text_form_widget.dart';

class UpdateStudent extends StatelessWidget {
  final int index;
  final StudentModel studentDat;
  UpdateStudent({Key? key, required this.index, required this.studentDat})
      : super(key: key);
  var formKey = GlobalKey<FormState>();
  var _upNameCtrl = TextEditingController();
  var _upAgeCtrl = TextEditingController();
  var _upBranchCtrl = TextEditingController();
  var _upPlaceCtrl = TextEditingController();
  var _upPhoneCtrl = TextEditingController();
  var _upImage;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _upImage = studentDat.image;
    if (_upNameCtrl.text.isEmpty) {
      _upNameCtrl.text = studentDat.name;
      _upAgeCtrl.text = studentDat.age;
      _upBranchCtrl.text = studentDat.branch;
      _upPlaceCtrl.text = studentDat.place;
      _upPhoneCtrl.text = studentDat.phone;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: blackclr,
          elevation: 0,
          toolbarHeight: 65,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: const Text(
            'Edit Student',
            style: mainTitle,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: blackclr,
                  radius: 70,
                  child: BlocBuilder<StudentsCubit, StudentsState>(
                    builder: (context, state) {
                      return Container(
                        width: 135,
                        height: 135,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                    File(state.imgPath ?? studentDat.image)),
                                fit: BoxFit.cover),
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(135)),
                      );
                    },
                  ),
                ),
              ),

              sbHeight10,
              ElevatedButton.icon(
                  onPressed: () async {
                    _upImage = await pickImage(context, index);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Image')),
              sbHeight30,
              // Text Form Fields for inputing datas
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Name',
                formWidth: screenSize.width * 0.9,
                ctrl: _upNameCtrl,
                formKey: formKey,
              ),
              sbHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormWidget(
                    screenSize: screenSize,
                    hintTxt: 'Age',
                    formWidth: screenSize.width * 0.4,
                    isInputNumber: true,
                    ctrl: _upAgeCtrl,
                    formKey: formKey,
                  ),
                  TextFormWidget(
                    screenSize: screenSize,
                    hintTxt: 'Branch',
                    formWidth: screenSize.width * 0.4,
                    ctrl: _upBranchCtrl,
                    formKey: formKey,
                  ),
                ],
              ),
              sbHeight20,
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Place',
                formWidth: screenSize.width * 0.9,
                ctrl: _upPlaceCtrl,
                formKey: formKey,
              ),
              sbHeight20,
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Phone',
                formWidth: screenSize.width * 0.9,
                ctrl: _upPhoneCtrl,
                isInputNumber: true,
                formKey: formKey,
              ),
              sbHeight30,

              // Submit button
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, fixedSize: const Size(110, 45)),
                  onPressed: () {
                    saveButtonClicked(context);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ));
  }

  Future pickImage(BuildContext context, int idx) async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      BlocProvider.of<StudentsCubit>(context).updateImage(img.path);
      return img.path;
    } else {
      return;
    }
  }

  saveButtonClicked(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final String _name = _upNameCtrl.text.trim();
      final String _branch = _upBranchCtrl.text.trim();
      final String _age = _upAgeCtrl.text.trim();
      final String _place = _upPlaceCtrl.text.trim();
      final String _phone = _upPhoneCtrl.text.trim();
      final _studentDetail = StudentModel(
          name: _name,
          age: _age,
          branch: _branch,
          place: _place,
          phone: _phone,
          image: _upImage);
      BlocProvider.of<StudentsCubit>(context)
          .updateStudent(_studentDetail, index);
      Navigator.of(context).pop();
      _upNameCtrl.clear();
      _upAgeCtrl.clear();
      _upBranchCtrl.clear();
      _upPlaceCtrl.clear();
      _upPhoneCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Edited Successfully',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      return;
    }
  }
}
