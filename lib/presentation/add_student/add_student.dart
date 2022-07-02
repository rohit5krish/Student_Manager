import 'package:flutter/material.dart';
import 'package:student_management/core/constants.dart';
import 'package:student_management/presentation/add_student/widget/text_form_widget.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _branchCtrl = TextEditingController();
  final _placeCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

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
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: Text(
            'Add Student',
            style: mainTitle,
          ),
          centerTitle: true,
          // actions: [
          //   TextButton.icon(
          //       style: TextButton.styleFrom(primary: Colors.black),
          //       onPressed: () {
          //         final isValid = formKey.currentState!.validate();
          //       },
          //       icon: Icon(Icons.save),
          //       label: Text('Save')),
          //   sbWidth10
          // ],
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
                  onPressed: () {},
                  icon: Icon(Icons.image),
                  label: Text('Image')),
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
                      primary: Colors.green, fixedSize: Size(110, 45)),
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    print(isValid);
                    if (isValid) {
                      final String name = _nameCtrl.text;
                      final String branch = _branchCtrl.text;
                      print(name);
                      print(branch);
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ));
  }
}
