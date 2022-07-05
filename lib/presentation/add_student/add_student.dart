import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/application/students/students_cubit.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/domain/student_model.dart';
import 'package:student_management/presentation/widgets/text_form_widget.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var _nameCtrl = TextEditingController();
  var _ageCtrl = TextEditingController();
  var _branchCtrl = TextEditingController();
  var _placeCtrl = TextEditingController();
  var _phoneCtrl = TextEditingController();
  var _image;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
            'Add Student',
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
                  child: ClipOval(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvgBWbSH3w-xh3MDUV9ARmjVGaYr5SqRC6fg&usqp=CAU',
                      fit: BoxFit.cover,
                      height: 135,
                      width: 135,
                    ),
                  ),
                ),
              ),
              sbHeight10,
              ElevatedButton.icon(
                  onPressed: () async {
                    _image = await pickImage();
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Image')),
              sbHeight30,
              // Text Form Fields for inputing datas
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Name',
                formWidth: screenSize.width * 0.9,
                ctrl: _nameCtrl,
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
                    ctrl: _ageCtrl,
                  ),
                  TextFormWidget(
                    screenSize: screenSize,
                    hintTxt: 'Branch',
                    formWidth: screenSize.width * 0.4,
                    ctrl: _branchCtrl,
                  ),
                ],
              ),
              sbHeight20,
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Place',
                formWidth: screenSize.width * 0.9,
                ctrl: _placeCtrl,
              ),
              sbHeight20,
              TextFormWidget(
                screenSize: screenSize,
                hintTxt: 'Phone',
                formWidth: screenSize.width * 0.9,
                ctrl: _phoneCtrl,
                isInputNumber: true,
              ),
              sbHeight30,

              // Submit button
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, fixedSize: const Size(110, 45)),
                  onPressed: () {
                    addButtonClicked(context);
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

  Future pickImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img!.path;
  }

  addButtonClicked(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (isValid && _image != null) {
      final String _name = _nameCtrl.text.trim();
      final String _branch = _branchCtrl.text.trim();
      final String _age = _ageCtrl.text;
      final String _place = _placeCtrl.text;
      final String _phone = _phoneCtrl.text;
      final _studentDetail = StudentModel(
          name: _name,
          age: _age,
          branch: _branch,
          place: _place,
          phone: _phone,
          image: _image);

      BlocProvider.of<StudentsCubit>(context).addStudent(_studentDetail);
      Navigator.of(context).pop();
      _nameCtrl.clear();
      _ageCtrl.clear();
      _branchCtrl.clear();
      _placeCtrl.clear();
      _phoneCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Student Added Successfully',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ));
    } else if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please Upload an Image',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
      return false;
    } else {
      return;
    }
  }
}
