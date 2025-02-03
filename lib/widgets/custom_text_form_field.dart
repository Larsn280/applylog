import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool? startValidation;
  final GlobalKey<FormFieldState>? fieldKey;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.startValidation = false,
    this.fieldKey,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black),
      child: TextFormField(
        key: widget.fieldKey,
        controller: widget.controller,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 13.0,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(fontSize: 13.0, color: Colors.white),
        validator: widget.validator,
        onChanged: (value) {
          if (widget.startValidation == true) {
            widget.fieldKey?.currentState?.validate();
          }
        },
      ),
    );
  }
}
