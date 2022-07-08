import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String hintTxt;
  final double formWidth;
  final bool isInputNumber;
  final TextEditingController ctrl;
  final GlobalKey<FormState> formKey;
  const TextFormWidget({
    Key? key,
    required this.screenSize,
    required this.hintTxt,
    required this.formWidth,
    required this.ctrl,
    this.isInputNumber = false,
    required this.formKey,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: formWidth,
      child: TextFormField(
        controller: ctrl,
        keyboardType: isInputNumber ? TextInputType.number : TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) {
          if (value.isNotEmpty) {
            formKey.currentState!.validate();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter $hintTxt';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          border: const OutlineInputBorder(),
          labelText: hintTxt,
        ),
      ),
    );
  }
}
